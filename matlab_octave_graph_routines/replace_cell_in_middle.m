function final_C = replace_cell_in_middle(C,D,i)
    % C: a cell of things
    % D: another cell of things
    % i: the index where things are being replaced
    
    % final_C: the C{i} is replaced by elements of D, if D has k things in
    % it, then length of final_C is k-1 more than C
    
    final_C = cell(1,length(C) + length(D) - 1); %memory preallocation
    
    for j = 1:i-1 % first i-1 are moved untouched
        final_C{j} = C{j};
    end
    
    for j = 1:numel(D) % i-th one is replaced by all members of D
        final_C{i-1+j} = D{j};
    end
    
    for j = i+1:length(C) % last elements of C are shifted to the end
        final_C{numel(D) + j - 1} = C{j};
    end
     
end