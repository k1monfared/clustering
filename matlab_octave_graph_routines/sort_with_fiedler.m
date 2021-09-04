function [B,P] = sort_with_fiedler(A)
    % A is the adjacency matrix of a graph
    % A is symmetric
    % output a is the algebraic connectivity of the matrix (that is the
    % second smallest eigenvalu of the Laplacian
    % output class_list is a list of the same size as A with numbers 1 and
    % 2 in it, indicating which vertex belongs to which partition
    
    n = size(A,1);
    if n == 1
        a = 2;
        class_list = ones(1,n);
        return
    elseif n == 0
        a = 0;
        class_list = ones(1,n);
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
    [d,perm] = sort(diag(D)); %Matlab is not consistent with how it sorts
                              %the eigenvalues. so I have to sort it
                              %myself 
    V = V(:,perm); %and take care of the eigenvectors
                              
    a = d(2) - 1;  %then later here I subtract 1 from all eigenvalues.
                     %this doesn't really matter if I don't want to know
                     %what the second eigenvalue is, but if I want to know
                     %the algebraic connectivity of the original graph then
                     %this is needed.
    w = V(:,2);
    [~,P] = sort(w);
    
    B = A(P,P);
    
end