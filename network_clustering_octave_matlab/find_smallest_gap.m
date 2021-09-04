function [g,idxs] = find_smallest_gap(L)
    %L is a list of doubles
    %g is the length of the smallest gap
    %idxs is the list of all indices where the smallest gap happens between 
    %idx and idx+1 in the non-decrasingly sorted L
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    L = sort(L);
    g = L(end) - L(1); % an initial large value
    idxs = [];
    
    for i = 1:numel(L)-1
        test = L(i+1) - L(i);
        if test < g
            g = test;
            idxs = [];
            idxs(end+1) = i;
        elseif test == g
            idxs(end+1) = i;
        end
    end
    
end