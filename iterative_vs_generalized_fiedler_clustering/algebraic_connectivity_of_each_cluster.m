function a = algebraic_connectivity_of_each_cluster(A,C)
    % A is adjacency matrix of a graph
    % C is a cell of lists of indices of vertices from a clustering
    % REQUIRES:
        % normalized_algebraic_connectivity.m
    
    a = zeros(1,numel(C));
    for c = 1:numel(C)
        a(c) = normalized_algebraic_connectivity(A(C{c},C{c}));
    end
end