function a = anticorrelation_index(A)
    % Inputs:
    %   A: the (simple/signed/weigthed) adjacency matrix of a graph
    %
    % Outputs:
    %   a: sum of negative entries of A divided by sum of abosoulte values
    %       of all entries of A
    %
    %
    % Other routines used:
    %   positive_matrix.m
    %   negative_matrix.m
    %   numedges.m
    %
    % To do:
    %   [ ] update so that instead of modules it accepts a class index list
    %       as input
    
    AP = positive_matrix(A); % the positive part of the matrix
    AN = negative_matrix(A); % the negative part of the matrix
    % note that A = AP - AN

    sP = sum(sum(AP)); % sum of the positive part
    sN = sum(sum(AN)); % sum of the negative part

    a = sN / (sP + sN);
end 