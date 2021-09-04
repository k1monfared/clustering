function BRC = permute_matrix_per_cluster(A,C)
    %input: A a square symmetric matrix of size n
    %input: C a cell of lists where each list contains indices of vertices
    %in a clustering of n
    %output: BRC, the permuted matrix A where indices of each cluster appear
    %next to each other.
    %deas to improve: 
    %   sort lists where the largest list appears first
    %   sort each list so that the most "central" node in each list appears
    %   frist
    
    BR = []; %first permute rows
    for idx = 1:numel(C)
        BR = [BR ; A(C{idx},:)];
    end
    BRC = []; %then permute columns
    for idx = 1:numel(C)
        BRC = [BRC , BR(:,C{idx})];
    end
    
end