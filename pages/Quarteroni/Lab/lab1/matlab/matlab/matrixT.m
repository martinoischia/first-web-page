function T = matrixT(n)        
    T = zeros(n);
    
    % 1st solution
    T(1:2:n, 1:2:n) = 1;
    T(2:2:n, 2:2:n) = 1;
    
    % 2nd solution
%     for i = 1:n
%         for j = 1:n
%             T(i,j) = 1 - mod(i+j,2);
%         end
%     end
end