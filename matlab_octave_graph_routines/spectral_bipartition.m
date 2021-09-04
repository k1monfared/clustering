function LC = spectral_bipartition(A,C)
    % for a given array C the output is a cell of size 2 with two arrays
    % that are nonempty subsets of C and are complements of each other
    % the idea is to sort the indecies accoring to the entries of the
    % second smallest eigenvector of its laplacian, and then break it at
    % zero
    
    [class_list,~] = partition_with_fiedler(A(C,C));
    C1 = C(class_list == 1);
    C2 = C(class_list == 2);
    LC = {C1,C2};
end