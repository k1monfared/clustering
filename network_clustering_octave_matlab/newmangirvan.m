% Newman-Girvan community finding algorithm
% source: Newman, M.E.J., Girvan, M., "Finding and evaluating community structure in networks"
% Algorithm idea:
% 1. Calculate betweenness scores for all edges in the network.
% 2. Find the edge with the highest score and remove it from the network.
% 3. Recalculate betweenness for all remaining edges.
% 4. Repeat from step 2.
% INPUTs: adjacency matrix (adj), number of modules (k)
% OUTPUTs: modules (components) and modules history - each "current" module, Q - modularity metric
% Other routines used: edge_betweenness.m, subgraph.m, numedges.m
% GB, April 17, 2006, computing modularity, added April 28, 2011

function [module_hist,q_hist] = newmangirvan(A,k)

adj = positive_matrix(A); %only work with the positive part of the matrix

n=size(adj,1);
if nargin < 2
    k = n;
end

module_hist = ones(n,k); % current component
q_hist = zeros(1,k); % current component
modules{1}=[1:n];

curr_mod=1;

adj_temp=adj;

count = 1;
while length(modules)<k
    disp([ num2str(length(modules)) ' / ' num2str(k)])
    w = edge_betweenness(adj_temp);
    [wmax,indmax]=max(w(:,3));   % need to remove el(indmax,:)
    adj_temp(w(indmax,1),w(indmax,2))=0;
    adj_temp(w(indmax,2),w(indmax,1))=0;   % symmetrize
    
    if isconnected(adj_temp)
        continue; 
    end % keep on removing edges
    comp_mat = find_conn_comp(adj_temp);
    for c=1:length(comp_mat)
        modules{length(modules)+1} = modules{curr_mod}(comp_mat{c}); 
    end

    % remove "now" disconnected component (curr_mod) from modules
    modules{curr_mod}=modules{1};
    modules=modules(2:length(modules));
    
    modL=[];
    for j = 1:length(modules)
        modL(j) = length(modules{j}); 
    end
    [maxL,indL] = max(modL);
    curr_mod=indL;
    
    count = count+1;
    module_hist(:,count) = sorted_class_list(modules);
    q_hist(count) = girvan_newman_modularity(A,modules); % but compute the signed modularity 
    adj_temp=subgraph(adj,modules{indL});
end % end of while loop
disp([ num2str(length(modules)) ' / ' num2str(k)])

% computing the modularity for the final module break-down
% Defined as: Q=sum_over_modules_i (eii-ai^2) (eq 5) in Newman and Girvan.
% eij = fraction of edges that connect community i to community j
% ai=sum_j (eij)

% nedges=numedges(adj); % compute the total number of edges
% 
% Q = 0;
% for m=1:length(modules)
%   module=modules{m};
%   adj_m=subgraph(adj,module);
%   
%   e_mm=numedges(adj_m)/nedges;
%   a_m=sum(sum(adj(module,:)))/nedges-e_mm;
%   
%   Q = Q + (e_mm - a_m^2);
% end