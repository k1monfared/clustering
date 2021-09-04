function [C_history,Q_history,Z] = MethodA_hierarchical_fiedler(A)
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    n = size(A,1);
    C = {1:n};
    C_history = {C};
    Q_history = [girvan_newman_modularity(A,C)];
    Z = zeros(0,3); %this is used for drawing the dendogram
    t = 1;
    count = 1;
    z_height = 0;

    tempC = C;
    
    while numel(tempC) < n
        % order tempC from smallest algebraic connectivity to largest
        a = algebraic_connectivity_of_each_cluster(A,tempC);
        [~,order_a] = sort(a);
        tempC = order_cell_array(tempC,order_a);
        
        %look at the cluster with smallest algebraic connectivity
        if numel(tempC{1}) <= 1 %move it to last if it is 1 or zero vertex
            tempC{end+1} = sort(tempC{1});
            tempC(1) = [];
        else %otherwise, break it into two pieces
            newC = one_more_cluster_from_index_fiedler_alg_con(A,tempC,1);
            tempC(1) = [];
            tempC{end+1} = sort(newC{1});
            tempC{end+1} = sort(newC{2});
            
            % figure out its heigt in the dendrogram
            z_height = z_height - abs(girvan_newman_modularity(A,tempC)); %this is for the dedrogram
            if numel(newC{1}) > 1
                if numel(newC{2}) > 1
                    Z = [2*n-1-count, 2*n-2-count,z_height; Z];
                    count = count+2;
                else
                    Z = [2*n-1-count, newC{2}, z_height; Z];
                    count = count+1;
                end
            elseif numel(newC{2}) > 1
                Z = [2*n-1-count, newC{1}, z_height; Z];
                count = count+1;
            else
                Z = [newC{1}, newC{2}, z_height; Z];
            end
            
            %record the history for future generations to remember
            C_history{end+1} = tempC;
            Q_history(end+1) = girvan_newman_modularity(A,tempC);
        end
    end
    
    Z(:,3) = normalize_for_dendrogram(Z(:,3));
end