function A = random_bipartite_graph(m,n,p)
    % Returns a random bipartite graph on m and n vertices
    % p is probability of an edge. default: 1, i.e. complete bipartite
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    if nargin < 3
        p = 1;
    end
    O1 = zeros(m,m);
    O2 = zeros(n,n);
    B = rand(m,n);
    B = B > 1-p;
    A = [O1, B;
        B', O2];
end