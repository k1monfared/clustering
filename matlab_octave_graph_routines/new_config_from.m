function C = new_config_from(C)
    % Objective: given a cell of size 2 containing two disjoint arrays, the
    % funtion takes an element from one of them at random and puts it in
    % the other one, so that none of them becomes empty
    
    % Idea: if one of the arrays is of size 1, then choose the other
    % cluster, otherwise choose one at random. Then pick one element from
    % this cluster and put it in the other one.
    
    if size(C{1},2) <= 1
        if size(C{2},2) <= 1
            return % if both are of the same size 1, there is no new config
                   % so this will just return the original one.
        end
        k = 2;
    elseif size(C{2},2) <= 1
        k = 1;
    else
        k = randi([1,2]);
    end
    
    [x,idx] = datasample(C{k},1);
    C{k}(idx) = [];
    C{3-k} = [C{3-k}, x];
end