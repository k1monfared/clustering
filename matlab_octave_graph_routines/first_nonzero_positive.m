function V = first_nonzero_positive(V)
    % Inputs 
    %   V: a matrix
    %
    % Outputs:
    %   columns of V are scaled such that their first nonzero entry is
    %   positive
    
    for i = 1:size(V,2) %normalizing so that the first nonzero become positive
        flag = 0; %first nonzero entry is reached?
        row = 1; %start from the first row
        while flag == 0 %as long as you haven't reached the first nonzero entry
            if V(row,i) < 0 %if you reached the first entry and it is negative
                V(:,i) = -V(:,i); %flip the column
                flag = 1; %stop going through this column
            elseif V(row,i) > 0 % if you reached the first entry and it is positive
                flag = 1; %stop going through this column
            else %othewise
                row = row + 1; %go to the next row
            end
        end
    end
end