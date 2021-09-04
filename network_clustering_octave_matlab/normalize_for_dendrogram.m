function L = normalize_for_dendrogram(L)
    % L is a list of negative numbers and a zero
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    if L == 0
        L = L + 1;
        return
    end
     m = abs(max(nonzeros(L)));
     L = L/m;
     M = min(L);
     L = L + (-M + 1);
     w = max(L);
     L = L/w;
end