function [best_idx,best_sumd] = best_polar_cluster_kmeans(theta)
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    xx = cos(theta);
    yy = sin(theta);
    maxk = length(theta); % max number of cluters
    idxs = zeros(length(theta),maxk); %idx history
    sumds = zeros(1,maxk);
    for i = 1:maxk
        [idx,~,sumd] = kmeans([xx;yy]',i);
        idxs(:,i) = idx;
        sumds(i) = sum(sumd);
    end
    
    left_angles = zeros(1,length(sumds));
    left_angles(1) = pi/2;
    Dla = zeros(1,length(sumds));
    for i = 2:length(sumds)
        left_angles(i) = atan(sumds(i-1)-sumds(i));
        Dla(i-1) = left_angles(i) - left_angles(i-1);
    end
    Dla(end) = -left_angles(end);
    [~,id] = min(Dla);
    best_idx = idxs(:,id);
    best_sumd = sumds(id);
end