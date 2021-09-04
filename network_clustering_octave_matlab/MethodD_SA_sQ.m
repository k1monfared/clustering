function [C_history,Q_history,best_C,best_Q,nmods] = MethodD_SA_sQ(A,k, diagonal)
    % for the given matrix A this function clusters its graph with
    % maximizing signed modularity of the matrix using the simulated
    % annealing method.
    
    %%% INPUTS: 
    % A is the (signed/weighted) adjacency matrix of a graph.
    % k is the desired maximum number of clusters, default is the size of 
    % the matrix.
    % diagonal = 0 turns all the diagonal entries into zero (default), 
    % otherwise it keeps the diagonal entries intact.
    
    %%% OUTPUTS:
    % C_history: a cell containing the clustering history. C_history{i} is
    % the set of i clusters.
    % Q_history: an array containig the modularity history. Q_history(i) is
    % the signed modularity of A with th clustering given by C_history{i}
    % best_C: is the clustering with maximum signed modularity
    % best_Q: is the maximum signed modularity obtained by clustering given
    % by best_C
    % nmods: is the number of clusters in best_C
    
    %%% OTHER MODULES USED
    % MethodD_hierarchical_SA_Q.m
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    
    
    n = size(A,1); % size of the matrix
    if nargin < 3
        % if diagonal is not given, set the to default = 0
        diagonal = 0;
        sprintf('The input "diagonal" is not given. Setting it equal to 0.')
        if nargin < 2 % if k is not given set if to default = size of the matrix
            k = n;
            sprintf('The input "k" is not given. Setting it equal to number of vertices: %0.0f.', n)
        end
    end
    
    if diagonal == 0 % zero out the diagonal entries
        A = A - diag(diag(A));
        sprintf('Setting all the diagonal entries equal to zero.')
    end
    
    % do the lustering, no more than k clusters though
    [C_history,Q_history] = MethodD_hierarchical_SA_Q(A,k);

    %now find the best signed modulairty
    [best_Q,idx] = max(Q_history);
    best_C = C_history{idx};
    nmods = numel(best_C);
end