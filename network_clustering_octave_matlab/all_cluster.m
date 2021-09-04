clear; clc;
[signals, r2] = clustered_signals([3,7],1000);
plot(signals(:,r2))

[all_clusters, all_modularities, note] = cluster_signals(signals(:,r2));


%%
% Here are all the steps, one by one:
%% Form network
noise_level = 0;
noise = normrnd(0, noise_level, size(signals,1), size(signals,2));
network = corrcoef(signals(:,r2)+noise);
imagesc(network)
colorbar
colormap('jet')
%% Form null model
rewiring_probability = 1;
null_model = permute_edges_wighted(network,rewiring_probability);
imagesc(null_model)
colorbar
colormap('jet')
%% run clustering algorithms on it:
%%   1- HF
[network_hf_clusters, network_hf_modularity] = best_cluster_with_fiedler(network,size(network,1));

subplot(1,6,1)
    imagesc(network_hf_clusters)
    title('HF')
    xlabel(sprintf( 'Q = %1.2f, %d clusters', network_hf_modularity, length(unique(network_hf_clusters))))
    set(gca,'Xtick',[])
%% 2- SC
[network_sc_clusters, network_sc_modularity, network_sc_sumd] = best_cluster_with_spectral_coordinates(network,size(network,1));

subplot(1,6,2)
    imagesc(network_sc_clusters)
    title('SC')
    xlabel(sprintf( 'Q = %1.2f, %d clusters', network_sc_modularity, length(unique(network_sc_clusters))))
    set(gca,'Xtick',[])
%% 3- GN
[network_gn_clusters, network_gn_modularity] = best_cluster_with_girvan_newman(network,size(network,1));

subplot(1,6,3)
    imagesc(network_gn_clusters)
    title('GN')
    xlabel(sprintf( 'Q = %1.2f, %d clusters', network_gn_modularity, length(unique(network_gn_clusters))))
    set(gca,'Xtick',[])
%% 4- SA
[network_sa_clusters, network_sa_modularity] = best_cluster_with_SA_sQ(network,size(network,1));

subplot(1,6,4)
    imagesc(network_sa_clusters)
    title('SA')
    xlabel(sprintf( 'Q = %1.2f, %d clusters', network_sa_modularity, length(unique(network_sa_clusters))))
    set(gca,'Xtick',[])
%% 5- Kuramoto
[network_kr_clusters, network_kr_modularity, network_kr_sumd] = best_cluster_with_kuramoto(network,size(network,1));

subplot(1,6,5)
    imagesc(network_kr_clusters)
    title('KR')
    xlabel(sprintf( 'Q = %1.2f, %d clusters', network_kr_modularity, length(unique(network_kr_clusters))))
    set(gca,'Xtick',[])
%% 6- Just the signals clustered using k-means
[network_km_clusters, network_km_modularity, network_km_sumd] = best_cluster_kmeans_stable(signals,size(signals,2));

subplot(1,6,6)
    imagesc(network_km_clusters)
    title('KM')
    xlabel(sprintf( 'Q = %1.2f, %d clusters', network_km_modularity, length(unique(network_km_clusters))))
    set(gca,'Xtick',[])
%%
colormap(distinguishable_colors(size(signals,2)))