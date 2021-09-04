function [first, middle, last] = find_first_last_below_above(list,num1,num2)
    % find the location of the first occurence of a number below num1 in the 
    % list, if it doesn't happen, it will return empty. Also it will return
    % the lat occurence of a number above num2. if num2 is not given it is
    % equal to num 1. middle is the last time num1 appears.
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    if nargin < 3
        num2 = num1;
    end
    
    for i = 1:length(list)
        if list(i) < num1
            first = i;
            break;
        end
    end
    if ~(exist('first','var'))
        first = [];
    end
    
    for i = length(list):-1:1
        if list(i) < num1
            middle = i;
            break;
        end
    end
    if ~(exist('middle','var'))
        middle = [];
    end
    
    for i = length(list):-1:1
        if list(i) < num2
            last = i;
            break;
        end
    end
    if ~(exist('last','var'))
        last = [];
    end
    
end