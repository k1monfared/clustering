function a = algebraic_connectivity_of_each_cluster(A,C)
    % A is adjacency matrix of a graph
    % C is a cell of lists of indices of vertices from a clustering
    % a is the list of algebraic connecitivities of each cluster in C as a
    % standalone graph.
    % REQUIRES:
        % normalized_algebraic_connectivity.m
    % 
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    a = zeros(1,numel(C));
    for c = 1:numel(C)
        a(c) = normalized_algebraic_connectivity(A(C{c},C{c}));
    end
end