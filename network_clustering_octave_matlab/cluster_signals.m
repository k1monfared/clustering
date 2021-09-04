function [all_clusters, ...
          all_modularities, ...
          note] = cluster_signals(signals,...
                                  max_num_clusters,...
                                  noise_level,...
                                  rewiring_probability,...
                                  plots_flag)
    % Inputs:
    %   signals: each columns is an observed signal from a channel
    %            each row one sample
    %   max_num_clusters: maximum number of clusters to be considered
    %                     default = number of signals
    %   noise_level: standard deviation of the normal random noise added to
    %                signals.     
    %                default = 0
    %   rewiring_probability: the probability of rewiring each edge to
    %                         create the null model
    %                         default = 1
    %   plots_flag: whether to plot the outputs (1) or not (0)
    %               default: 1
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    if nargin < 5
        plots_flag = 1;
        if nargin < 4
            rewiring_probability = 1;
            if nargin < 3
                noise_level = 0;
                if nargin < 2
                    max_num_clusters = size(signals,2);
                end
            end
        end
    end
    
    % Create noise
    if noise_level > 0
        noise = normrnd(0, noise_level, size(signals,1), size(signals,2));
    else
        noise = zeros(size(signals));
    end
    
    % add noise and create network
    network = corrcoef(signals+noise);
    
    if plots_flag
        figure()
        imagesc(network)
        colorbar
        colormap('jet')
        caxis([-1,1])
        title('Correlation matrix of the signals')
    end
    
    % Form null model
    %%%%%%%%%%%%%%%% I haven't used this to compare yet %%%%%%%%%%%%%%%%%%%
    null_model = permute_edges_wighted(network,rewiring_probability);
    
    if plots_flag
        figure()
        imagesc(null_model)
        colorbar
        colormap('jet')
        caxis([-1,1])
        title('Correlation matrix of the null model')
    end
    
                % run clustering algorithms on the network %
    % 1- HF
    disp('Calculating the Hierarcical Fiedler (HF) clusters...')
    [network_hf_clusters, network_hf_modularity] = best_cluster_with_fiedler(network,max_num_clusters);
    % 2- SC
    disp('Calculating the Spectral Coordinates (SC) clusters...')
    [network_sc_clusters, network_sc_modularity, network_sc_sumd] = best_cluster_with_spectral_coordinates(network,max_num_clusters);
    % 3- GN
    disp('Calculating the Girvan-Newman (GN) clusters...')
    [network_gn_clusters, network_gn_modularity] = best_cluster_with_girvan_newman(network,max_num_clusters);
    % 4- SA
    disp('Calculating the Simulated Annealing (SA) clusters...')
    [network_sa_clusters, network_sa_modularity] = best_cluster_with_SA_sQ(network,max_num_clusters);
    % 5- Kuramoto
    disp('Calculating the Kuramoto (KR) clusters...')
    [network_kr_clusters, network_kr_modularity, network_kr_sumd] = best_cluster_with_kuramoto(network,max_num_clusters);
    % 6- Just the signals clustered using k-means
    disp('Calculating the K-means (KM) clusters...')
    [network_km_clusters, network_km_modularity, network_km_sumd] = best_cluster_kmeans_stable(signals,max_num_clusters);
    
    % prepare outputs
    all_clusters = [network_hf_clusters,...
                    network_sc_clusters,...
                    network_gn_clusters,...
                    network_sa_clusters,...
                    network_kr_clusters,...
                    network_km_clusters];
    all_modularities = [network_hf_modularity,...
                        network_sc_modularity,...
                        network_gn_modularity,...
                        network_sa_modularity,...
                        network_kr_modularity,...
                        network_km_modularity];
    note = {'methods in order are:',...
             '1: Hierarchical Fiedler (HF)',...
             '2: Spectral Coordinates (SC)',...
             '3: Girvan-Newman (GN)',...
             '4: Simulated Annealing (SA)',...
             '5: Kuramoto (KR)',...
             '6: K-means (KM)'};
         
    % Plot things
    if plots_flag
        figure()
        subplot(1,6,1)
            imagesc(network_hf_clusters)
            title('HF')
            xlabel(sprintf( 'Q = %1.2f, %d clusters', network_hf_modularity, length(unique(network_hf_clusters))))
            set(gca,'Xtick',[])
        subplot(1,6,2)
            imagesc(network_sc_clusters)
            title('SC')
            xlabel(sprintf( 'Q = %1.2f, %d clusters', network_sc_modularity, length(unique(network_sc_clusters))))
            set(gca,'Xtick',[])
        subplot(1,6,3)
            imagesc(network_gn_clusters)
            title('GN')
            xlabel(sprintf( 'Q = %1.2f, %d clusters', network_gn_modularity, length(unique(network_gn_clusters))))
            set(gca,'Xtick',[])
        subplot(1,6,4)
            imagesc(network_sa_clusters)
            title('SA')
            xlabel(sprintf( 'Q = %1.2f, %d clusters', network_sa_modularity, length(unique(network_sa_clusters))))
            set(gca,'Xtick',[])
        subplot(1,6,5)
            imagesc(network_kr_clusters)
            title('KR')
            xlabel(sprintf( 'Q = %1.2f, %d clusters', network_kr_modularity, length(unique(network_kr_clusters))))
            set(gca,'Xtick',[])
        subplot(1,6,6)
            imagesc(network_km_clusters)
            title('KM')
            xlabel(sprintf( 'Q = %1.2f, %d clusters', network_km_modularity, length(unique(network_km_clusters))))
            set(gca,'Xtick',[])
        colormap(distinguishable_colors(size(signals,2)))
    end
end