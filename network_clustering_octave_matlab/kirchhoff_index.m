function kf = kirchhoff_index(A)
    % Ref: http://mathworld.wolfram.com/KirchhoffIndex.html
    %
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    %               EXAMPLES:
    % % Complete tripartite graphs K_{n,n,n}
    % for n = 1:10
    %     N = [n,n,n];
    %     P = ones(length(N)) - eye(length(N));
    %     A = random_multi_bottleneck_graph(N,P); 
    %     kirchhoff_index(A)
    % end
    % % Complete Bipartite graphs K_{n,n}
    % for n = 1:10
    %     N = [n,n];
    %     P = ones(length(N)) - eye(length(N));
    %     A = random_multi_bottleneck_graph(N,P); 
    %     kirchhoff_index(A)
    % end
    % % Complete graphs K_{n}
    % for n = 1:10
    %     A = ones(n) - eye(n);
    %     kirchhoff_index(A)
    % end
    
    R = resistance_distance_matrix(A);
    kf = sum(sum(R))/2;
end