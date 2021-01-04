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
	
	% mass coefficient
	mass = Dati.mass;
	stiff= Dati.stiff;
	if isfield(Dati,'transp')
		transp= Dati.transp;
		else 
		transp = [0,0]	;
	end
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
		iglo = connectivity(1:nln,ie);
		
		% BJ        = Jacobian of the elemental map 
		% pphys_2D = vertex coordinates in the physical domain   
		% in realtà sono i quadrature points
		[BJ, pphys_2D] = C_get_Jacobian(femregion.coord(iglo,:), nodes_2D, Dati.MeshType);
		
		%=============================================================%
		% STIFFNESS MATRIX
		%=============================================================%
		
		% Local stiffness matrix 
		local_mass = zeros (nln, nln);
		local_stif = zeros (nln, nln);
		quadra_stif = zeros (Dati.nqn_2D, 1);
		quadra_mass = zeros (Dati.nqn_2D, 1);
		
		
		for i = 2:nln
			for j = 1:i-1
				for in = 1:Dati.nqn_2D
					quadra_stif(in)= det(BJ(:,:,in)) * w_2D(in) * (BJ(:,:,in)'\Grad(in,:,j)')'*...
					(BJ(:,:,in)'\Grad(in,:,i)') ;
					quadra_mass(in)= det(BJ(:,:,in)) * w_2D(in) * dphiq(:,in,i) * dphiq(:,in,j);
				end
				local_stif(i,j) = sum (quadra_stif);
				local_mass(i,j) = sum (quadra_mass);
			end			
		end
		
		local_stif= local_stif+local_stif';
		
		local_mass= local_mass+local_mass';
		
		for i = 1:nln
			for in = 1:Dati.nqn_2D
				quadra_stif(in)= det(BJ(:,:,in)) * w_2D(in) * (BJ(:,:,in)'\Grad(in,:,i)')'*...
				(BJ(:,:,in)'\Grad(in,:,i)') ;
				quadra_mass(in)= det(BJ(:,:,in)) * w_2D(in) * dphiq(:,in,i) * dphiq(:,in,i);				
			end
			local_stif(i,i) = sum (quadra_stif);
			local_mass(i,i) = sum (quadra_mass);
		end			
		
		
		local_trans = zeros (nln, nln,2);
		quadra_trans= zeros (2,Dati.nqn_2D);
		
		if isfield(Dati,'transp')
			for i = 1:nln
				for j = 1:nln
					for in = 1:Dati.nqn_2D
						quadra_trans(1,in)= det(BJ(:,:,in)) * w_2D(in) * dphiq(:,in,i) * Grad(in,1,j);
						
						quadra_trans(2,in)= det(BJ(:,:,in)) * w_2D(in) * dphiq(:,in,i) * Grad(in,2,j);
					end
					local_trans(i,j,1) = sum (quadra_trans(1,:));
					local_trans(i,j,2) = sum (quadra_trans(2,:));
				end			
			end
		end
		
		% Assembly phase for stiffness matrix
		A(iglo,iglo)= A (iglo,iglo) + mass*local_mass + stiff*local_stif + transp(1)*local_trans(:,:,1) +transp(2)*local_trans(:,:,2);
		
		
		%==============================================
		% FORCING TERM --RHS
		%==============================================
		
		% Local load vector
		force = inline(Dati.force,'x', 'y');
		
		localf = zeros (nln, 1);
		for i = 1:nln
			for j = 1:Dati.nqn_2D
				localf(i) = localf(i) + det(BJ(:,:,in)) * w_2D(j) * dphiq (:,j,i) * force (pphys_2D(j,1),pphys_2D(j,2));
			end
		end			
		% Assembly phase for the load vector
		f(iglo) = f (iglo) + localf;
		
	end
	
