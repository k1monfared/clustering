function B = unique_ordered_clusters(A)
    % given a set of n labels, it renames the labels from 1 to n
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    c = unique(A);
    B = zeros(size(A));
    for i = 1:length(A)
        B(i) = find(c == A(i));
    end
end