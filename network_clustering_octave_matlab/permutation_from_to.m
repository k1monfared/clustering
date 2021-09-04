function [I, PMat] = permutation_from_to(A,B)
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    [~,IA] = sort(A);
    [~,IB] = sort(B);
    I(IB) = IA;
    PMat(:,I) = eye(length(A));
end