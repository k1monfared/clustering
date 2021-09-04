


% This function is not complete yet!!



function T = all_kuramoto_things(y,T)
    %inputs: y, signals in its columns columns
    %       T: range of variance of noise added to the signal for example
    %       0:.001:0.01, if empty, then no noise is added.
    
    n = size(y,2); %number of signals
    m = 100; % number of times per noise level
    
    if isempty(T)
        T = [0];
    end
    
    
    Rho = zeros(n,n,m); %the network
    Q = zeros(1,m); % it's modularity for any noise level added
    N = zeros(n,m); % the clustering
    
    for t = 1:length(T)
        a = T(t); %multiplier of the std for the noise power
        Noise = normrnd(0.0, a, size(y,1), size(y,2)); % generate the noise of appropriate power and size
        yn = y + Noise; %add the noise
        A = corrcoef(ywn);
        Rho(:,:,t) = A;
        
        
        
        
    end
    



end