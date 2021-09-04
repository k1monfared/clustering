function kf = kirchhoff_index_absolute_spectral(A)
    % Ref: https://link.springer.com/content/pdf/10.1007%2Fs10910-008-9459-3.pdf
    %
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    %               EXAMPLES:
    % % Complete tripartite graphs K_{n,n,n}
    % for n = 1:10
    %     N = [n,n,n];
    %     P = ones(length(N)) - eye(length(N));
    %     A = random_multi_bottleneck_graph(N,P); 
    %     kirchhoff_index_spectral(A)
    % end
    % % Complete Bipartite graphs K_{n,n}
    % for n = 1:10
    %     N = [n,n];
    %     P = ones(length(N)) - eye(length(N));
    %     A = random_multi_bottleneck_graph(N,P); 
    %     kirchhoff_index_spectral(A)
    % end
    % % Complete graphs K_{n}
    % for n = 1:10
    %     A = ones(n) - eye(n);
    %     kirchhoff_index_spectral(A)
    % end
    
    n = size(A,1);
    L = absolute_laplacian(A);
    E = sort(eig(L));
    E1 = E(2:end);
    kf = n*sum(1./E1);
end