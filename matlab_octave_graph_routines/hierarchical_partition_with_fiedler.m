function [idx_history,Q_history] = hierarchical_partition_with_fiedler(A,k)
    n = size(A,1);
    if nargin < 2
        k = n;
    end
    C = {1:n};
    C_history = {C};
    Q_history = [girvan_newman_modularity(A,C)];
    AP = positive_matrix(A); % only work with the positive part of the matrix so that the fiedler method works
    idx_history = zeros(n,k);
%     Z = zeros(0,3); %this is used for drawing the dendogram
%     t = 1;
%     count = 1;
%     z_height = 0;

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
            
            % figure out its heigt in the dendrogram
%             z_height = z_height - abs(girvan_newman_modularity(A,tempC)); %this is for the dedrogram
%             if numel(newC{1}) > 1
%                 if numel(newC{2}) > 1
%                     Z = [2*n-1-count, 2*n-2-count,z_height; Z];
%                     count = count+2;
%                 else
%                     Z = [2*n-1-count, newC{2}, z_height; Z];
%                     count = count+1;
%                 end
%             elseif numel(newC{2}) > 1
%                 Z = [2*n-1-count, newC{1}, z_height; Z];
%                 count = count+1;
%             else
%                 Z = [newC{1}, newC{2}, z_height; Z];
%             end
            
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