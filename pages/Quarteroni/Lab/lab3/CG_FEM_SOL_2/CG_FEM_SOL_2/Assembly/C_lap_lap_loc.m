function A_loc = C_lap_lap_loc(nln, w_2D, BJ, Grad) 

    n_quad = length(w_2D);
    A_loc = zeros(nln,nln);
    
%     % 1) most general
    for i = 1:nln
        for j = 1:nln
            % int_Ke grad(phi_i) * grad(phi_j)
            for q = 1:n_quad                
                grad_phi_i = Grad(q,:,i)'; %2x1
                grad_phi_j = Grad(q,:,j)'; %2x1
                B = BJ(:,:,q);             %2x2       
                A_loc(j,i) = A_loc(j,i) ...
                    + (B'\grad_phi_i)'*(B'\grad_phi_j) ...
                    * w_2D(q) * det(B);
            end
        end
    end    
    
%     % 2)  optimized
%     detB = det(BJ(:,:,1));
%     B = BJ(:,:,1);
%     for i = 1:nln
%         for j = 1:nln
%             for q = 1:n_quad                
%                 grad_phi_i = Grad(q,:,i)';
%                 grad_phi_j = Grad(q,:,j)';                                
%                 A_loc(j,i) = A_loc(j,i) ...
%                     + (B'\grad_phi_i)'*(B'\grad_phi_j) ...
%                     * w_2D(q) * detB;
%             end
%         end
%     end
       
%     % 3) only for P1 elements on triangular mesh
%     detB = det(BJ(:,:,1));
%     BmT = inv(BJ(:,:,1))';
%     for i = 1:nln
%         for j = 1:nln           
%             A_loc(j,i) = 0.5 * (BmT*Grad(1,:,i)')'*(BmT*Grad(1,:,j)') * detB;
%         end
%     end
    
    % Assembly phase for stiffness matrix    
%     %1)
%     for i = 1:nln
%         for j = 1:nln
%             A(iglo(i),iglo(j)) = A(iglo(i),iglo(j)) + A_loc(i,j);
%         end
%     end
    % 2)
end