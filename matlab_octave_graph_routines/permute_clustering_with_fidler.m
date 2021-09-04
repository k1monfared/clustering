function [C,P] = permute_clustering_with_fidler(A,idx)
k = max(idx);
P = [];
for t = 1:k
    B = A(idx==t,idx==t);
    [~,p] = sort_with_fiedler(B);
    P = [P; p];
    C = A(P,P);
end
