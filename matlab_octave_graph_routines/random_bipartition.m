function C = random_bipartition(C)
    % for a given array C the output is a cell of size 2 with two arrays
    % that are nonempty random subsets of C and are complements of each 
    % other
    
    n = size(C,2);
    k = randi([1,n-1]); % since I don't want to any of the sets to be empty 
                        % I choose size of one of them to be between 1 and
                        % n-1
    C1idx = randperm(n,k);
    C1 = C(C1idx);
    C2 = setdiff(C,C1);
    C = {C1,C2};
end