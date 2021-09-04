function s = estimate_end_time(i,n,st)
    % this will estimate when your for loop will end
    % idea of how to use:
    %     n = 100;
    %     for i = 1:n
    %         estimate_end_time(i,n)
    %         pause(1)
    %     end
    % NOTE: this will write a file on the current folder called
    %       '__start_time__.mat'
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    if i == 1
        if nargin < 3
            start_time = datetime;
        else
            start_time = st;
        end
        save('__start_time__','start_time')
        s = sprintf('Current time: %s. Completed: 0%%.', ...
            datetime);
    else
        if nargin < 3
            load('__start_time__','start_time')
        else
            start_time = st;
        end
        current_time = datetime;
        total_time_elapsed = current_time - start_time;
        total_average_pace = total_time_elapsed / (i-1);
        total_estimated_remaining_time = (n-i) * total_average_pace;
        
        s = sprintf('Current time: %s. Completed: %2.2f%%. Estimated end time: %s', ...
            datetime, ...
            i/n*100, ...
            total_estimated_remaining_time + datetime);
    end
end