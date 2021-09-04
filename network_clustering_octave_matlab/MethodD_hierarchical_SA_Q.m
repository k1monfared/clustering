function [C_history,Q_history] = MethodD_hierarchical_SA_Q(A,t)
    % t is number of clusters you want
    
    %%% OTHER MUDULES USED
    % girvan_newman_modularity.m
    % algebraic_connectivity_of_each_cluster.m
    % positive_matrix.m
    % order_cell_array.m
    % one_more_cluster_from_index_SA_Q.m
    % normalize_for_dendrogram.m
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    
    
    n = size(A,1);
    if nargin <2
        t = n;
    end
    C = {1:n};
    C_history = {C};
    Q_history = [girvan_newman_modularity(A,C)];
%     Z = zeros(0,3); %this is used for drawing the dendogram
%     count = 1;
%     z_height = 0;
    tempC = C;
    
    while numel(tempC) < t
        disp(numel(tempC))
        % order tempC from smallest algebraic connectivity to largest
        a = algebraic_connectivity_of_each_cluster(positive_matrix(A),tempC);
        [~,order_a] = sort(a);
        tempC = order_cell_array(tempC,order_a);
        
        %look at the cluster with smallest algebraic connectivity
        if numel(tempC{1}) <= 1 %move it to last if it is 1 or zero vertex
            tempC{end+1} = sort(tempC{1});
            tempC(1) = [];
        else %otherwise, break it into two pieces
            newC = one_more_cluster_from_index_SA_Q(A,tempC,1);
            tempC{end+1} = sort(tempC{1}(newC{1}));
            tempC{end+1} = sort(tempC{1}(newC{2}));
            tempC(1) = [];
            
            % figure out its heigt in the dendrogram
            %tempz = girvan_newman_modularity(A,tempC);
%             z_height = z_height - abs(tempz); %this is for the dedrogram
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
    
%     Z(:,3) = normalize_for_dendrogram(Z(:,3));
    
    % if t < n, then the Z matrix does not include all the vertices, here I
    % make them all meet at the very bottom by putting them at the end. In
    % this case the labels of the leaves are meaningless, and shall be read
    % from the C_history{end}
%     MM = max(max(Z(:,1:2)));
%     ZZ = Z(:,1:2);
%     missing = setdiff(1:MM,ZZ);

%     for i = numel(missing):-2:1
%         Z = [ missing(i),missing(i-1),0 ;Z];
%     end
end