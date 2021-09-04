function NL = absolute_normalized_laplacian(A)
    % A is the adjacency matrix of a graph.
    % A is symmetric.
    % output a is the nomralized laplacian of graph of A.
    % REQUIRES: 
        % absolute_laplacian.m
    % 
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    n = size(A,1); % number of vertices
    if n <= 1
        return
    end
    L = absolute_laplacian(A); % find the absolute Laplacian
    D = diag(L); % diagonal degrees matrix
    NL = L; % copy L
    for i = 1:n % scale rows and columns
        sqd = sqrt(D(i));
        if sqd ~= 0 % leave alone the isolated vertices
            NL(i,:) = NL(i,:)/sqd;
            NL(:,i) = NL(:,i)/sqd;
        end
    end
end