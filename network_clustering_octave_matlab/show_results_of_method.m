function [p,idx,k,q] = show_results_of_method(nn,method)
    %input: 
    %   nn = 1, 2, ..., 31
    %   method = 
    %       'hfp': hierarchical Fiedler with positive part of the matrix
    %       'hfj': hierarchical Fiedler with A + J
    %       'hfs': hierarchical Fiedler with sigmoidish(A)
    %       'sa': simulated annealing maximizing signed modularity
    %       'gna': agglomerative Girvan-Newman
    %       'sc': spectral coordinates
    %       'scs': spectral coordinates with 
    %outputs:
    %   p: is the list of vertices after permutation
    %   idx: is the class of each original index, for example if idx(125)=4
    %        it means vertex 125 is in cluster 4
    %   k: optimal number of clusters
    %   q: optimal signed modularity, which is given in idx
    %   figure 1: 
    %       left: original matrix
    %       right: permuted matrix after clustering
    %   figure 2:
    %       left: color coded classes of each node in their original
    %             position
    %       right: color coded classes after permutation
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    %load the actual matrix
    load(['rho_x_unfilt' num2str(nn) '.mat']); 
    eval(sprintf('A = rho_x_unfilt%d;', nn));
    A = (A+A')/2; %seems like A is not exactly symmetric (round off errors) 
                  %so I symmetrize it first
    
    %load the results of this matrix
    load(['rho_x_unfilt' num2str(nn) '_' method '.mat']);
    
    [q,k] = max(q_history); %find the clustring with maximum signed modulairty
    idx = idx_history(:,k);
    
    if strcmp(method,'gna') || strcmp(method,'sc') || strcmp(method,'scs')
        [C,p] = permute_with_clustering(A,idx_history(:,k));
    else
        [C,p] = permute_with_clustering(A,idx_history(:,end));
    end
    
    
    %load the results for all 31 matrices
    %load('Z:\2018_04_16_clustering_31_278\rho_x_unfilt_all_' method '.mat');

    colors = distinguishable_colors(k);
    
    f1 = figure();
        subplot(1,2,1)
            imagesc([A]);
            axis square
            title(['rho unfiltered ' num2str(nn)])
            colormap('jet');
            colorbar;
            caxis([-1,1])
            set(gca, 'XTick', 1:10:278)
            set(gca, 'YTick', 1:10:278)
            set(gca, 'XTickLabelRotation', 90)
            xlabel(['optimal number of clusters: ' num2str(k)])
            
        subplot(1,2,2)
            imagesc([C]);
            axis square
            title(['permuted with ' method])
            colormap('jet');
            colorbar;
            caxis([-1,1]);
            set(gca, 'XTick', 1:10:278)
            set(gca, 'YTick', 1:10:278)
            set(gca, 'XTickLabels', p(1:10:278))
            set(gca, 'YTickLabels', p(1:10:278))
            set(gca, 'XTickLabelRotation', 90)
            xlabel(['optimal signed modularity: ' num2str(q)])
            
     f2 = figure();
        subplot(1,2,1)
            imagesc([idx]);
            title(['clusters of rho unfiltered ' num2str(nn)])
            colormap(colors);
            colorbar;
            set(gca, 'XTick', [])
            set(gca, 'XTickLabels', [])
            set(gca, 'XTick', 1:10:278)
            set(gca, 'YTick', 1:10:278)
            set(gca, 'XTickLabelRotation', 90)
            
        subplot(1,2,2)
            imagesc([idx(p)]);
            set(gca, 'XTick', [])
            set(gca, 'YTick', 1:10:278)
            set(gca, 'XTickLabels', [])
            set(gca, 'YTickLabels', p(1:10:278))
            set(gca, 'XTickLabelRotation', 90)
            title(['permuted clusters with ' method])
            colormap(colors);
            colorbar;
end