function U = permute_edges_wighted(A,p)
    % A is the adjacency matrix of a graph
    % p is some probability
    % this permutes the weights of edges regardless of them being zero or
    % nonzero
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    U = triu(A);
    n = size(A,1);
    for i = 1:n
        for j = i+1:n
            if rand() < p % toss a coin
                x = U(i,j); % remember the weight of that edge
                a = floor( rand() * n) + 1; % choose another random vertex
                while ( i == a) % repeat until it is really another vertex
                    a = floor( rand() * n ) + 1;
                end;
            if(i < a) % add an edge here
                y = U(i,a); % remember the weight of that edge too
                U(i,a) = x; % replace their weights;
            else
                y = U(a,i); % remember the weight of that edge too
                U(a,i) = x;
            end;    
            U(i,j) = y; % replace their weights;
            end
        end
    end
    U = U+U'-diag(diag(A));
end