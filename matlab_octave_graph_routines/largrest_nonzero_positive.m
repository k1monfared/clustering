function V = largrest_nonzero_positive(V)
    % Inputs
    %	V: a matrix, the operation is done for each row
    %
    % Output:
    %   rows of V are multiplied by -1, if needed so that the entry with 
    %   largest magnitude in each row is positive
    
    for r = 1:size(V,1) %for each row
        v = V(r,:);
        [M,idx] = max(abs(v)); %find the entry with max magnitude
        if ~M == 0 % if the row is nonzero
            if v(idx) < 0 %if that entry is negative
                V(r,:) = -v; %flip the row
            end
        end
    end
end