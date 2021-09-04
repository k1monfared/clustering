function modules = index_list_to_clusters(idx,idxs)
    % idx is a list on length n with k distinct numbers in it
    % idx(i) is the modules number that i belongs to
    % modules is a cell of k lists where i in is list idx(i)
    % idxs is the list of the "names" of original nodes to be put in
    % different clusters, if it is not given it will be set to 1:n
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    n = numel(idx);
    
    if nargin < 2
        idxs = 1:n;
    end
    
    nmods = max(idx);
        
    modules = {};
     for i = 1:nmods
         modules{i} = [];
     end
     for i = 1:n
         modules{idx(i)} = [modules{idx(i)},idxs(i)];
     end
end