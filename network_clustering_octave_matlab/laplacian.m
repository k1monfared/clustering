function L = laplacian(A)
    % A is the adjacency matrix of a graph
    % A is symmetric
    % output a is the laplacian matrix of graph of A
    %
    % Note: if there are self loops, they are not counted in the degree!
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    
    n = size(A,1);
    if n == 0
        L = A;
        return
    end
    D = diag(sum(A));
    L = D - A; %Laplacian
end