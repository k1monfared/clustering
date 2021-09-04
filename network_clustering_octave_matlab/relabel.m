function B = relabel(A,P)
    %A is a given list of integers
    %P is a permutation (1D array) on max(A) elements
    %B is obtained from A by replacing each a in A with p(a)
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    B = zeros(size(A));
    u = unique(P,'stable');
    for i = 1:length(u)
        B(A==i) = u(i);
    end
end