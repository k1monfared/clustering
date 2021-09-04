function L = absolute_laplacian(A)
    % A is the adjacency matrix of a graph.
    % A is symmetric.
    % output a is the absolute laplacian matrix of graph of A where
    % diagonal entries are the sum of the abosulte values of the rows.
    % Having/not-having loops will make a difference here.
    % 
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    n = size(A,1); % size of the square matrix
    if n == 0 
        L = A;
        return
    end
    D = diag(sum(abs(A))); % find the degree of each vertex
    L = D - A; % Laplacian
end