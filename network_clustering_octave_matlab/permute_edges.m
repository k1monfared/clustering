function U = permute_edges(A,p)
    % A is the adjacency matrix of a graph
    % p is some probability
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    U = triu(A);
    n = size(A,1);

    for i = 1:n
        for j = i+1:n
            if (U(i,j) == 1 && rand() < p) % find an edge, and toss a coin
                U(i,j) = 0; % delete that edge
                a = floor( rand() * n) + 1; % choose another random vertex
                while ( U(a,i) == 1 || U(i,a) == 1 || i == a) % repeat until there is an edge
                    a = floor( rand()*n ) + 1;
                end; 
            if(i < a) % add an edge here
                U(i,a)=1;
            else
                U(a,i)=1;
            end;    
           end;
        end;
    end;

    U = U+U';
end