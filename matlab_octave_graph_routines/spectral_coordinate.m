function S = spectral_coordinate(A,k)
    % Inputs:
    %   A: a real symmetric matrix
    %   k: dimension of coordinates
    %       Default: 2
    %
    % outputs:
    %   S: rows are canonical spectral coordinates of each vertex of graph of A
    %       rows of S are normalized to have norm 1
    %       eigenvectors of A are scaled to have positive first nonzero entry
    %
    %   This is a modification based on [1].
    %
    % Other routines used:
    %   first_nonzero_positive.m
    %   largrest_nonzero_positive.m
    %
    % Reference: 
    %   [1] L. Wu, X. Wu, A. Lu and Y. Li, 
    %       "On Spectral Analysis of Signed and Dispute Graphs: Application
    %       to  Community Structure,"  
    %       IEEE Transactions on Knowledge and Data Engineering, 
    %       29, 7, 1480--1493, 2017.
    %       10.1109/TKDE.2017.2684809

    
    %taking care of the defaults
    if nargin < 2
        k = 2;
    end
    
    [V,D] = eig(full(A)); %find all eigenvalues and eigenvectors
    [~,perm] = sort(diag(D),'descend'); %sort eigenvalues from largest to smallest
    V = V(:,perm); %sort V from largest eigenvalue to smallest
    V = first_nonzero_positive(V); %make the first nonzero entry of each 
                                   %eigenvector positive
    S = V(:,1:k); %consider only the first k coordinates
    for i = 1:length(S) %for each spectral coordinates vector
        if ~norm(S(i,:)) == 0 %if it is not a zero vector
            S(i,:) = largrest_nonzero_positive(S(i,:)); %make largest entry positive
            S(i,:) = S(i,:)/norm(S(i,:)); %normalize to have  norm 2 of the vector be 1
        end
    end
end