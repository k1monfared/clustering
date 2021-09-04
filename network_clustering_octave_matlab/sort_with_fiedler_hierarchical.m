function [B,P] = sort_with_fiedler_hierarchical(A)
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    [B,~] = sort_with_fiedler(positive_matrix(A));
end