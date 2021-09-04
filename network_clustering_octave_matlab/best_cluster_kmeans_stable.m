function [best_idx, Q, best_sumd] = best_cluster_kmeans_stable(signals,maxk,max_iter,replicates)
    %each column of signals is a vector. the columns will be clustered
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    if nargin < 4
        replicates = 10;
        if nargin < 3
            max_iter = 1000;
            if nargin < 2
                maxk = size(signals,2); % max number of cluters
            end
        end
    end
    idxs = zeros(size(signals,2),maxk); %idx history
    sumds = zeros(1,maxk);
    for k = 1:maxk
        disp([ num2str(k) ' / ' num2str(maxk)])
        [idx,~,sumd] = kmeans(signals',k,'MaxIter',max_iter,'Replicates',replicates);
        idxs(:,k) = idx;
        sumds(k) = sum(sumd);
    end
    
    id = elbow(sumds,0);
    best_idx = idxs(:,id);
    best_sumd = sumds(id);
    
    A = corrcoef(signals);
    Q = girvan_newman_modularity(A,index_list_to_modules(best_idx));
end