function A = permute_edges_randomly(A,p)
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    n = size(A,1);
    U = triu(A); % just the edges
    [redge,cedge,~] = find(U > 0); %rows and columns of edges
    m = length(redge); %number of edges

    rndIDX = randperm(m); % randomly permute edges
    chosen_edges = [redge(rndIDX(1:round(p*m))),cedge(rndIDX(1:round(p*m)))];  % to choose p*m of them
    for i = 1:round(p*m)
        A(chosen_edges(i,1),chosen_edges(i,2)) = 0; % delete the edge
        A(chosen_edges(i,2),chosen_edges(i,1)) = 0; % and in the lower triangle
    end
    
    % now let's replace them
    V = triu(ones(n,n) - A - eye(n)); % just the non-edges of the new graph with p*m deleted edges
    [rnedge,cnedge,~] = find(V > 0); %rows and columns of nonedges
    nm = length(rnedge); % number of nonedges
    
    rndIDX = randperm(nm); % randomly permute the now nonedges to place edges there
    chosen_nonedges = [rnedge(rndIDX(1:round(p*m))),cnedge(rndIDX(1:round(p*m)))]; % choose p*m of them

    for i = 1:round(p*m)
        A(chosen_nonedges(i,1),chosen_nonedges(i,2)) = 1; % place an edge there
        A(chosen_nonedges(i,2),chosen_nonedges(i,1)) = 1; % and in the lower triangle
    end
end