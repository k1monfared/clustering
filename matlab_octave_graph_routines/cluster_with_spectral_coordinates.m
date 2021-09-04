function [idx_history, q_history, sumd_history] = cluster_with_spectral_coordinates(A,max_k)
    % Inputs:
    %   A: is the adjacency matrix of a (signed) graph
    %   max_k: maximum number of clusters
    %       Default: size(A,1)
    %
    % Outputs:
    %   idx_history: columns are lists that assigns a cluster number 
    %       (1,2,3,...) to each vertex according to their clustering with 
    %       spectral coordinates method for each clustering
    %   q_history: row vector of the Girvan-Newman modularity index for
    %       each clustering
    %   sumd_history: sum of within-cluster sums of point-to-centroid
    %       distances for each clustering
    %
    % all k-th columns correspond to the clustering into k clusters.
    %   
    % Other routines used:
    %   k_cluster_with_spectral_coordinates.m
    
    n = size(A,1);
    if nargin < 2
        max_k = n;
    end
    
    idx_history = zeros(n,max_k); %column i corresponds to clustering with k = i;
    q_history = zeros(1,max_k);
    sumd_history = zeros(1,max_k);
    
    U = spectral_coordinate(A,max_k); %find k-dimensional spectral coordinates
    for k = 1:max_k % for all possible sizes of clusterings
        [idx,~,sumd] = kmeans(U(:,k),k); %use kmeans method to find 
        modules = index_list_to_modules(idx); %turn the indexes to cell of classes
        q = girvan_newman_modularity(A,modules); %evaluate the signed version of Girvan-Newman modularity
        
        idx_history(:,k) = idx;
        q_history(k) = q;
        sumd_history(k) = sum(sumd);
    end
end