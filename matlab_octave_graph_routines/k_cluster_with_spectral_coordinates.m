function [idx,q,sumd] = k_cluster_with_spectral_coordinates(A,k)
    % Inputs:
    %   A: is the adjacency matrix of a (signed) graph
    %   k: number of clusters
    %       Default: 2
    %
    % Outputs:
    %   idx: a column that assigns a cluster number (1,2,3,...) to each vertex
    %   according to their clustering with spectral coordinates method
    %   q: the Girvan-Newman modularity index defined in [2]
    %   sumd: kx1 vector of within-cluster sums of point-to-centroid distances
    %   
    % Other routines used:
    %   spectral_coordinate.m
    %   index_list_to_modules.m
    %   girvan_newman_modularity.m
    
    %taking care of defaults
    if nargin < 2
        k = 2;
    end
    
    U = spectral_coordinate(A,k); %find k-dimensional spectral coordinates
    [idx,~,sumd] = kmeans(U,k); %use kmeans method to find 
    modules = index_list_to_modules(idx); %turn the indexes to cell of classes
    q = girvan_newman_modularity(A,modules); %evaluate the signed version of Girvan-Newman modularity
end