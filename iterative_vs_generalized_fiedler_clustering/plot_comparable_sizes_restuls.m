clear; clc

load('compare_hierarchical_fiedler_generalized_fiedler_1000iter_100stp.mat')

figure()
    plot(0:99,meanARI(1,:), 'b', 'LineWidth',2)
    hold on
    plot(0:99,meanARI(2,:), 'r', 'LineWidth',2)
    hold off
    grid on
    title('Adjusted Rand Index (intra-density = 90%)')
    legend({'Iterative Fiedler','Generalized Fiedler'})
    xlabel('inter density')
    ylabel('ARI')
    xlim([0,99])
    ylim([-.1,1])
    
figure()
    plot(0:99,meanGNM(3,:),'k', 'LineWidth',2)
    hold on
    plot(0:99,meanGNM(1,:),'b', 'LineWidth',2)
    plot(0:99,meanGNM(2,:),'r', 'LineWidth',2)
    hold off
    grid on
    title('Girvan-Newman Modularity (intra-density = 90%)')
    legend({'Original Clusters','Iterative Fiedler','Generalized Fiedler'})
    xlabel('inter density')
    ylabel('Modulairty')
    xlim([0,99])
    ylim([-1,1])

figure()
count = 0;
for t = 11:10:100;
    a = (t-1)/100;
    b = .9;
    N = [20,15,25,18];
    P = [b,a,a,a; 
        a,b,a,a; 
        a,a,b,a;
        a,a,a,b];
    A = random_multi_bottleneck_graph(N,P); 
    count = count+1;
    subplot(3,3,count)
        %imagesc(A)
        imagesc_clusters(A,N)
        %'Sample graph with intra-density = ' num2str(100*b) '%, '
        title(['inter density = ' num2str(100*a) '%'])
%         colorbar
%         colormap('jet')
%         caxis([-1,1])
        axis square
end