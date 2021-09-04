function B = negative_matrix(A)
    % this drops the positive entries of A and returns the negatice of that
    %
    % To do:
    %   [ ] add option for sparse or full matrix output
    %   [ ] this searches twice through the matrix, once to get the row and
    %   columns, and once to find the values. There should be a better way
    %   of doing this.
    [m,n] = size(A);
    [rowN,colN] = find(A<0);
    B = -full(sparse(rowN,colN,A(A<0),m,n));
end