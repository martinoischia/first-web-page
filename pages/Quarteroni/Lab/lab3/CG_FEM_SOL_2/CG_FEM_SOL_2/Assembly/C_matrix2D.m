function [A,f]=C_matrix2D(Dati,femregion)
%% [A,f] = C_matrix2D(Dati,femregion)
%==========================================================================
% Assembly of the stiffness matrix A and rhs f
%==========================================================================
%    called in C_main2D.m
%
%    INPUT:
%          Dati        : (struct)  see C_dati.m
%          femregion   : (struct)  see C_create_femregion.m
%
%    OUTPUT:
%          A           : (sparse(ndof,ndof) real) stiffnes matrix
%          f           : (sparse(ndof,1) real) rhs vector


addpath FESpace
addpath Assembly

fprintf('============================================================\n')
fprintf('Assembling matrices and right hand side ... \n');
fprintf('============================================================\n')


% connectivity infos
ndof         = femregion.ndof; % degrees of freedom
nln          = femregion.nln;  % local degrees of freedom
ne           = femregion.ne;   % number of elements
connectivity = femregion.connectivity; % connectivity matrix


% shape functions
[basis] = C_shape_basis(Dati);

% quadrature nodes and weights for integrals
[nodes_2D, w_2D] = C_quadrature(Dati);

% evaluation of shape bases 
[dphiq,Grad] = C_evalshape(basis,nodes_2D);


% Assembly begin ...
A = sparse(ndof,ndof);  % Global Stiffness matrix
f = sparse(ndof,1);     % Global Load vector

for ie = 1 : ne
     
    % Local to global map --> To be used in the assembly phase
    iglo = connectivity(1:nln,ie);% 3 x 1 
    % iglo(1) = global index of the 1st local dof
    % iglo(2) = global index of the 2nd local dof
    % iglo(3) = global index of the 3rd local dof
  
    % BJ        = Jacobian of the elemental map 
    % pphys_2D = vertex coordinates in the physical domain   
    [BJ, pphys_2D] = C_get_Jacobian(femregion.coord(iglo,:), nodes_2D, Dati.MeshType);
   
    %=============================================================%
    % STIFFNESS MATRIX
    %=============================================================%
    
    % Local stiffness matrix     
    A_loc = Dati.mu    * C_lap_lap_loc(nln, w_2D, BJ, Grad) ...
          + Dati.sigma * C_mass_loc(nln, w_2D, BJ, dphiq);
    
    A(iglo,iglo) = A(iglo,iglo) + A_loc;
    
    %==============================================
    % FORCING TERM --RHS
    %==============================================

    % Local load vector
    f_loc = zeros(nln,1);
    force = inline(Dati.force, 'x', 'y');
    for i = 1:nln
        for q = 1:length(w_2D)
            phi_i = dphiq(1,q,i);
            x_q = pphys_2D(q,1);
            y_q = pphys_2D(q,2);
            f_x_q= force(x_q,y_q);
            B = BJ(:,:,q);                
            f_loc(i) = f_loc(i) ...
                + phi_i * f_x_q ...
                * w_2D(q) * det(B);
        end
    end

    % Assembly phase for the load vector
%     for i = 1:nln
%         f(iglo(i)) = f(iglo(i)) + f_loc(i);
%     end
    f(iglo) = f(iglo) + f_loc;

end
