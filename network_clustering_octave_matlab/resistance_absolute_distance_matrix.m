function R = resistance_absolute_distance_matrix(A)
    % A is the adjacency matrix of a graph
    % R is the resistance distance matrix as in http://mathworld.wolfram.com/ResistanceDistance.html
    % Example
    % N = [5,5];
    % P = [0,1; 
    %      1,0];
    % A = random_multi_bottleneck_graph(N,P); 
    % plot(graph(A),'layout','circle')
    % R = resistance_distance_matrix(A);
    % imagesc(R)
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    n = size(A,1); %number of nodes
    Gamma = absolute_laplacian(A) + 1/n; 
    G1 = inv(Gamma);
    R = zeros(n);
    for i = 1:n
        for j = 1:n
            R(i,j) = G1(i,i) + G1(j,j) - 2*G1(i,j);
        end
    end
end