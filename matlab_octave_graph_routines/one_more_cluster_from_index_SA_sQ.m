function newC = one_more_cluster_from_index_SA_sQ(A,C,idx)
    %input: A adjacency matrix of a graph on n vertices
    %input: C a cell of list of clusters of vertices of G
    %input: idx an index of C, C{idx} will be broken into two pieces
    %output: just the new clusters
    %the clustering of C{idx} will be done by using simulated annealing to
    %maximize Girvan-Newman modularity
    % REQUIRES:
        % random_bipartition.m
        % girvan_newman_modularity.m
        % simulated_annealing_max.m
    
    n = length(C{idx});
    if n <= 1
        newC = C{idx};
        return
    elseif n == 2
        newC = {C{idx}(1),C{idx}(2)};
        return
    end
        
    oldC = C{idx};
    B = zeros(size(A,1));
    B(oldC,oldC) = A(oldC,oldC);
    f = @girvan_newman_modularity;
    
    
    
    
    %%%%%%%%%%% Main Functiona Call 1 %%%%%%%%%%%%%%%%%%%%
    %initial = max_of_F_GN_SC(A(oldC,oldC));
    %initial = random_bipartition(oldC);
    initial = spectral_bipartition(A,oldC);
    
    
    if B == 0 %if the graph is the empty graph, then return the initial
        newC = initial;
        return
    end
    Mmax = 400; %max number of temperatures
    
    
    
    %%%%%%%%%%%%%% Main Function Call 2 %%%%%%%%%%%%%%%%%%%
    [newC,~] = simulated_annealing_max(f,B,initial,Mmax);
end