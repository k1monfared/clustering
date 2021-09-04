function NL = normalized_laplacian(A)
    % A is the adjacency matrix of a graph
    % A is symmetric
    % output a is the nomralized laplacian of graph of A
    % REQUIRES: 
        % laplacian.m
    
    n = size(A,1);
    if n == 1
        na = 2;
        return
    end
    if n == 0
        na = 0;
        return
    end
    D = diag(sum(A));
    L = laplacian(A);

    NL = L; % copy L
    for i = 1:n % scale rows and columns
        d = D(i,i);
        if d ~= 0 % leave alone the isolated vertices!!
            NL(i,:) = NL(i,:)/sqrt(d);
            NL(:,i) = NL(:,i)/sqrt(d);
        end
    end
end