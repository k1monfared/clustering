m  = 40;
n = 10;
p = 10;
q = 40;

a = 10;
b = 7; 
c = 0;
d = 0;
f = 40;

A = a * ones(m,m);
B = b * ones(m,n);
C = c * ones(m,p);
D = d * ones(m,q);
E = a * ones(n,n);
F = f * ones(n,p);
G = c * ones(n,q);
H = a * ones(p,p);
I = b * ones(p,q);
J = a * ones(q,q);

M = [A , B , C , D;
     B', E , F , G;
     C', F', H , I;
     D', G', I', J];

figure()
    imagesc(M)
    colormap('jet')
    colorbar

[idx_history, q_history] = hierarchical_partition_with_fiedler_sorted(M,4);
figure()
    manual = [ones(m,1);2*ones(n+p,1);3*ones(q,1)];
    imagesc([idx_history,manual])
    colormap(distinguishable_colors(4))
figure()
    plot([q_history,girvan_newman_modularity(M,{1:40,41:60,61:100})])
    ylabel('modularity')
    xlabel('number of clusters')
    set(gca,'XTickLabels',[1,2,3,4,3])
    set(gca,'XTick',[1,2,3,4,5])

figure()
    imagesc_clusters(M,[m+n,p+q])
    colormap('jet')
figure()
    imagesc_clusters(M,[m,n,p,q])
    colormap('jet')
figure()
    imagesc_clusters(M,[m,n+p,q])
    colormap('jet')
    
%%
