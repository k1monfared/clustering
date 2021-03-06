function a = algebraic_connectivity(A)
    % A is the adjacency matrix of a graph
    % A is symmetric
    % output a is the algebraic connectivity of the matrix (that is the
    % second smallest eigenvalu of the Laplacian
    % output class_list is a list of the same size as A with numbers 1 and
    % 2 in it, indicating which vertex belongs to which partition
    % REQUIRES: 
        % laplacian.m
    % 
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    n = size(A,1); % number of vertices
    if n <= 1
        a = n;
        return
    end
                                     % here I'm using the normalized Laplacian
                                     %since the second smallest
                                     %eigenvalue of Laplacian does depend
                                     %on the number of vertices. On the
                                     %other hand the second smalles
                                     %eigenvalue of the normalized
                                     %laplacian does not depend on the
                                     %number of vertices, that is, it
                                     %bounded above by n/(n-1) (Mike
                                     %Caver's PhD thesis page 27), and it
                                     %is easy to see that the eigenvector
                                     %corresponding to both second smallest
                                     %eigenvectors have the same signs at
                                     %each entry.
    L = laplacian(A);
    
    Lp = eye(n) + L; %whatever algorithm Matlab uses to find the eigenvalues 
                     %makes this to fail (due to a zero eigenvalue) hence I
                     %add identity which shifts all eigenvalues one up and
                     %keeps the eigenvectors intact
    D = sort(eig(full(Lp)));
    a = D(2)-1; % subtracting 1 because I added 1 in line 36.
end