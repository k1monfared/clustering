function [idx, q] = best_cluster_with_girvan_newman(A,max_k)
    % Inputs:
    %   A: is the adjacency matrix of a (signed) graph
    %   max_k: maximum number of clusters
    %       Default: min(size(A,1), 10)
    %
    % Outputs:
    %   idx: a column that assigns a cluster number (1,2,3,...) to each vertex
    %   according to the best clustering with fiedler method
    %   q: the Girvan-Newman modularity index defined in [2]
    %   sumd: sum of the within-cluster sums of point-to-centroid distances
    %
    % The best clustering is chosen based on what maximizes the signed
    % Girvan-Newman modularity
    %   
    % Other routines used:
    %   cluster_with_spectral_coordinates.m
    
    %taking care of the defaults
    if nargin < 2
        max_k = min(size(A,1), 10);
    end
    
    [idx_history,q_history] = newmangirvan(A,max_k); %find all clustrings of all sizes
    [q,k] = max(q_history); %find the clustring with maximum signed modulairty
    idx = idx_history(:,k); %the corresponding clustering
end