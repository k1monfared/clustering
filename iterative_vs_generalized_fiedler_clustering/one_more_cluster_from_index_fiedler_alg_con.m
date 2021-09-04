function newC = one_more_cluster_from_index_fiedler_alg_con(A,C,idx)
    %input: A adjacency matrix of a graph on n vertices
    %input: C a cell of list of clusters of vertices of G
    %input: idx an index of C, C{idx} will be broken into two pieces
    %output: just the new clusters
    %the clustering of C{idx} will be done by using Fiedler eigenvector
    
    oldC = C{idx};
    B = A(oldC,oldC);
    
    [tempC,~] = partition_with_fiedler(B);
    
    newC = index_list_to_modules(tempC,C{idx});
end