function [idx_history] = generalized_partition_with_fiedler(A,k)
    % A is the adjacency matrix of a graph
    % k is the number of clusters
    % A is symmetric
    % output a is the algebraic connectivity of the matrix (that is the
    % second, third, ... smallest eigenvalue of the Laplacian
    % output class_list is a list of the same size as A with numbers 1 and
    % 2 in it, indicating which vertex belongs to which partition
    
    n = size(A,1);
    if n < 2
        idx_history = ones(n,1);
        return
    end
    D = diag(sum(A));
    L = D - A; %Laplacian
    Lp = eye(n) + L; %whatever algorithm Matlab uses to find the eigenvalues 
                     %makes this to fail (due to a zero eigenvalue) hence I
                     %add identity which shifts all eigenvalues one up and
                     %keeps the eigenvectors intact
    [V,D] = eig(full(Lp)); %if the matrix is too large (maybe > 1000) then 
                           %use (eigs(LP,2,'sm') and take care of the order
                           %that eigenvalues/vectors are appearing in V and
                           %D. But beware that the Lancsoz algorithm uses a
                           %randomized initial vector and that might change
                           %the convergence and hence the final result. if
                           %you want to always get the same answer, then
                           %you should also consider fixing the initial
                           %vector for eigs function. see 'doc eigs'.
    [~,perm] = sort(diag(D)); %Matlab is not consistent with how it sorts
                              %the eigenvalues. so I have to sort it
                              %myself 
    V = V(:,perm); %and take care of the eigenvectors
    Vn = V < 0;
    idx_history = bi2de(Vn(:,2:k))+1;
    
end