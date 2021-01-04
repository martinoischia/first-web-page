function A_loc = C_mass_loc(nln, w_2D, BJ, dphiq)

    n_quad = length(w_2D);
    A_loc = zeros(nln,nln);
    
    for i = 1:nln
        for j = 1:nln
            % int_Ke (phi_i) * (phi_j)
            for q = 1:n_quad                
                phi_i = dphiq(1,q,i);
                phi_j = dphiq(1,q,j);
                B = BJ(:,:,q);     
                A_loc(j,i) = A_loc(j,i) ...
                    + phi_i * phi_j * w_2D(q) * det(B);
            end
        end
    end    

end