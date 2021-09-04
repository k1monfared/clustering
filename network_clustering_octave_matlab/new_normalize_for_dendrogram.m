function L = new_normalize_for_dendrogram(L)
    % L is a list of positive numbers
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    if L == 0
        L = L + 1;
        return
    end
    n = size(L,1)+1;
    m = min(L);
    M = max(L);
    
    slope = (n-2)/(n*(M-m));
    y_int = 1/n;
    
    L = slope * (L - m) + y_int;
    
end