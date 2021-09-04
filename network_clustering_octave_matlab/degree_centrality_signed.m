function c = degree_centrality_signed(A,s)
    % A is the signed weighted adjacency matrix 
    % s is a boolean. true -> signed (default), false -> abs val
    % c is a vector that is the degree centralities of the vertices
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    if nargin < 2
        s = true;
    end
    
    if ~s
        A = abs(A);
    end
    c = sum(A)';
    
    %c = c/norm(c);
end