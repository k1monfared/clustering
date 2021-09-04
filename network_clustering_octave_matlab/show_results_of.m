function [p,idx,k,q] = show_results_of(nn)
    %input: 1, 2, ..., 31
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
    load(['rho_x_unfilt' num2str(nn) '_hf.mat']);
    
    %load the results for all 31 matrices
    load('Z:\2018_04_16_clustering_31_278\rho_x_unfilt_all_hf.mat');

    p = P(:,nn); %the corresponding clustering
    [C,p] = permute_with_clustering(A,idx_history(:,end)); %the permuted matrix
    k = K(nn); %the number of clusters
    idx = idx_history(:,k); %the clusters
    q = Q(nn);
    colors = distinguishable_colors(k);
    
    f = figure();
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
            title(['permuted with hierarchical fiedler (positive)'])
            colormap('jet');
            colorbar;
            caxis([-1,1]);
            set(gca, 'XTick', 1:10:278)
            set(gca, 'YTick', 1:10:278)
            set(gca, 'XTickLabels', p)
            set(gca, 'YTickLabels', p)
            set(gca, 'XTickLabelRotation', 90)
            xlabel(['optimal signed modularity: ' num2str(q)])
            
     f = figure();
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
            set(gca, 'YTickLabels', p)
            set(gca, 'XTickLabelRotation', 90)
            title(['permuted clusters with hierarchical fiedler (positive)'])
            colormap(colors);
            colorbar;
end