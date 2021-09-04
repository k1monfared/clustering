function [best_idx,best_sumd] = best_polar_cluster_kmeans_stable(theta,maxk)
    %
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    xx = cos(theta(:));
    yy = sin(theta(:));
    if nargin < 2
        maxk = length(theta); % max number of cluters
    end
    idxs = zeros(length(theta),maxk); %idx history
    sumds = zeros(1,maxk);
    for i = 1:maxk
        [idx,~,sumd] = kmeans([xx,yy],i,'MaxIter',1000,'Replicates',10);
        idxs(:,i) = idx;
        sumds(i) = sum(sumd);
    end
    
    id = elbow(sumds,0);
    best_idx = idxs(:,id);
    best_sumd = sumds(id);
end