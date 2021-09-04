function [C_history,Q_history] = MethodB_spectral_coordinates(A)
    %A is the adjacency matrix of a signed graph
    %A is a symmetric matrix 
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    n = size(A,1);
    C_history = {};
    Q_history = [];
    
    for k = 1:n
        U = spectral_coordinate(A,k); %I'm being stupid here, but oh well!
        [idx,~] = kmeans(U,k);
        modules = index_list_to_modules(idx);
        C_history{end+1} = modules;
        Q_history = [Q_history, girvan_newman_modularity(A,modules)];
    end
end