function Z = my_linkage(C_history,Q_history)
    % C_history is a cell with n entries. Entry i is a clustering of graph
    % G into i clusters
    % Q_history is the girvan newman signed modularity of corresponding 
    % clusterings 
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    n = size(C_history,2);
    
    if nargin < 2 %if the modularities are not given, then the heights are all one
        Q_history = ones(1,n);
    end
    
    all_clusters = {};
    for i = 1:n
        all_clusters{end+1} = num2str(i);
    end

    current_z = 0;
    Z = zeros(0,3);

    for i = n-1:-1:1;
        current_z = current_z + abs(Q_history(i+1));
        A = index_list_to_modules(C_history(:,i));
        B = index_list_to_modules(C_history(:,i+1));
        current_indices = [];
        future_indices = [];
        for j = 1:numel(A)
            len1 = length(A{j});
            if len1 > 1
                for k = 1:numel(B)
                    len2 = length(setdiff(A{j},B{k}));
                    if ~ (len2 == 0)
                        if ~ (len2 == len1)
                            current_indices = [j];
                            future_indices = [future_indices, k];
                        end
                    end

                end
            end
        end
        all_clusters{end+1} = num2str(sort(A{current_indices}));
        ind1=find(ismember(all_clusters,num2str(sort(B{future_indices(1)}))));
        ind2=find(ismember(all_clusters,num2str(sort(B{future_indices(2)}))));
        Z = [Z; ind1,ind2,current_z];
    end
    Z(:,3) = new_normalize_for_dendrogram(Z(:,3));
end