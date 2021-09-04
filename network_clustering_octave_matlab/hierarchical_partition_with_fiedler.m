function [idx_history,Q_history] = hierarchical_partition_with_fiedler(A,k)
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    n = size(A,1);
    if nargin < 2
        k = n;
    end
    C = {1:n};
    C_history = {C};
    Q_history = [girvan_newman_modularity(A,C)];
    AP = positive_matrix(A); % only work with the positive part of the matrix so that the fiedler method works
    idx_history = zeros(n,k);

    tempC = C;
    while numel(tempC) < n
        if numel(tempC) == k
            break;
        end
        % order tempC from smallest algebraic connectivity to largest
        a = algebraic_connectivity_of_each_cluster(AP,tempC);
        [~,order_a] = sort(a);
        tempC = order_cell_array(tempC,order_a);
        
        %look at the cluster with smallest algebraic connectivity
        if numel(tempC{1}) <= 1 %move it to last if it is 1 or zero vertex
            tempC{end+1} = sort(tempC{1});
            tempC(1) = [];
        else %otherwise, break it into two pieces
            newC = one_more_cluster_from_index_fiedler_alg_con(AP,tempC,1);
            tempC(1) = [];
            tempC{end+1} = sort(newC{1});
            tempC{end+1} = sort(newC{2});
            
            %record the history for future generations to remember
            C_history{end+1} = tempC;
            Q_history(end+1) = girvan_newman_modularity(A,tempC);
        end
    end
    
    for i = 1:k
        idx = sorted_class_list(C_history{i});
        idx_history(:,i) = idx;
    end
    
%     Z(:,3) = normalize_for_dendrogram(Z(:,3));
end