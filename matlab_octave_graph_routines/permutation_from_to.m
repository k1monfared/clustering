function [I, PMat] = permutation_from_to(A,B)
[~,IA] = sort(A);
[~,IB] = sort(B);
I(IB) = IA;
PMat(:,I) = eye(length(A));