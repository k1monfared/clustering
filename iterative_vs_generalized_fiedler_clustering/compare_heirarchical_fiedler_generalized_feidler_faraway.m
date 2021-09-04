clear; clc;

N = [100,12,8,15];
orig_idx = [];
for i = 1:length(N)
    orig_idx = [orig_idx; i*ones(N(i),1)];
end
    
k = 4;     
m = 1000;

meanARI = zeros(2,100);
meanGNM = zeros(2,100);

for t = 1:100
    a = (t-1)/100;
    b = .9;
    P = [b,a,a,a; 
         a,b,a,a; 
         a,a,b,a;
         a,a,a,b];
    ARI = zeros(2,m);
    GNM = zeros(3,m);
    for j = 1:m
        disp([t,j])
        A = random_multi_bottleneck_graph(N,P); 
        idx_historyg = generalized_partition_with_fiedler(A,ceil(log2(k))+1);
        [idx_historyh,~] = hierarchical_partition_with_fiedler(A);
        ARI(1,j) = rand_index(idx_historyh(:,k),orig_idx,'adjusted');
        ARI(2,j) = rand_index(idx_historyg,orig_idx,'adjusted');
        
        GNM(1,j) = girvan_newman_modularity(A,index_list_to_modules(idx_historyh(:,k)));
        GNM(2,j) = girvan_newman_modularity(A,index_list_to_modules(idx_historyg));
        GNM(3,j) = girvan_newman_modularity(A,index_list_to_modules(orig_idx));
        
    end
    meanARI(1,t) = mean(ARI(1,:));
    meanARI(2,t) = mean(ARI(2,:));
    
    meanGNM(1,t) = mean(GNM(1,:));
    meanGNM(2,t) = mean(GNM(2,:));
    meanGNM(3,t) = mean(GNM(3,:));
    
    
end
% save('compare_hierarchical_fiedler_generalized_fiedler_2clusters_of_different_sizes_1000iter_100stp.mat')