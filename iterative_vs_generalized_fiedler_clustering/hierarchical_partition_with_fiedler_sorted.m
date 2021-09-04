function [idx_history,Q_history] = hierarchical_partition_with_fiedler_sorted(A,k)
    % k is the maximum number of clusters needed
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
         disp(numel(tempC))
        % order tempC from smallest algebraic connectivity to largest
        a = algebraic_connectivity_of_each_cluster(AP,tempC);
        [~,order_a] = sort(a);
        count = 1; % reset counter
        
        %look at the cluster with smallest algebraic connectivity
        if numel(tempC{order_a(count)}) <= 1 %go to the next one
            count = count + 1;

        else %otherwise, break it into two pieces
            newC = one_more_cluster_from_index_fiedler_alg_con(AP,tempC,order_a(count));
            tempC = replace_cell_in_middle(tempC,newC,order_a(count));
            
            %record the history for future generations to remember
            C_history{end+1} = tempC;
            Q_history(end+1) = girvan_newman_modularity(A,tempC);
        end
    end
    
    for i = 1:k
        idx = class_list(C_history{i});
        idx_history(:,i) = idx;
    end
    
end