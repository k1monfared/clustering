function [best_idx, Q, best_sumd] = best_cluster_with_kuramoto(A,max_k,imax,tol,m_kuramoto,coupling,tmax)
    % Inputs:
    %   A: input coupling matrix (weighted signed adjacency matrix of the
    %       graph)
    %   max_k: maximum number of clusters, default: number of vertices
    %   imax: number of initialziations, the final result is the average of
    %       all these realizations, default: 1000
    %   tol: tolerance of erorr for stabilization, if the order parameter
    %       is less then this in consecutive iterations, the system is
    %       considered stable, default: 10^(-5)
    %   m_kuramoto: length of memory for stabilization, that is the
    %       difference of this many consecutive iterations should be less
    %       than tol for the system to be considered stable, default: 1000
    %   coupling: coupling strength of the network, default: 0.1
    %   tmax: number of iterations for ode45 solver, default: 10^4
    %
    % outputs: 
    %   best_idx: best clustering out of all initializations and k-means
    %       clusterings
    %   Q: the modularity of the best clustering
    %   best_sumd: best sum of distances
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com

    if nargin < 7
        tmax = 10000; % number of iterations for ode45 method
        if nargin < 6
            coupling = .1; % coupling strength
            if nargin < 5
                m_kuramoto = 1000; % length of memory for stabilization
                if nargin < 4
                    tol = 10^(-5); % tolerance of error for stabilization
                    if nargin < 3
                        imax = 1000; % I'm going to average over imax iterations with different random initializations
                        if nargin < 2
                            max_k = size(A,1);
                        end
                    end
                end
            end
        end
    end
    
    % run the kuramoto model until it is stablizaed and only read the final
    % phases after stabilization for each initialization
    [~, ~, ~, ~, Yn] =  Kuramoto_stable(A,tmax,coupling,m_kuramoto,tol,imax);
    
    % find the best clustering based on the minimum distance from the
    % centroids in the k-means method for each initialization. 
    best_sumd = inf;
    disp('Clustering Kuramoto final phases for each initialization...')
    for k = 1:imax
        fprintf('.')
        if ~ mod(k,80) % print out the status every 80 steps
            fprintf('\n')
            fprintf('%d / %d ', k, imax)
        end
        [temp_idx,temp_sumd] = best_polar_cluster_kmeans_stable(Yn(:,k),max_k); 
        if temp_sumd < best_sumd
            best_sumd = temp_sumd;
            best_idx = temp_idx;
        end
    end
    fprintf('\n')
    
    % find the modularity of the clustering 
    Q = girvan_newman_modularity(A,index_list_to_modules(best_idx));
end