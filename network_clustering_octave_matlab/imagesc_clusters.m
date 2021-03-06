function [first,second] = imagesc_clusters(A,N)
    % A is a matrix
    % N is the size of clusters in order 
    % output is the imagesc A with squares around the clusters
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    p = [];
    for i = 1:length(N)
        p(end+1) = sum(N(1:i));
    end
    
    first = [0, 0];
    for i = 2:2:length(p)
        first = [first, p(i), p(i)];
    end
    if mod(length(N),2)
        first = [first, p(end)];
    end
    
    second = [0];
    for i = 1:2:length(p)
        second = [second, p(i), p(i)];
    end
    if ~mod(length(N),2)
        second = [second,p(end)];
    end
    
    first = first + 0.5;
    second = second + 0.5;
    
%     f = figure();
        imagesc(A)
        axis square
        hold on
        plot(first, second,'r','LineWidth',2)
        plot(second, first,'r','LineWidth',2)
end