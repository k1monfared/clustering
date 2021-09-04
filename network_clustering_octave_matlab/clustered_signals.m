function [signals, r2] = clustered_signals(N,m)
    % goal: create N(1) signals that are somewhat correlated and N(2) signals
    % that are somewhat correlated, but the two sets of signals are anti-correlated.
    %
    % inputs:
    %   m is the number of samples, default = 1000
    %   N is a list of length 2, N(1) is the number of channels in the first
    %   cluster and N(2) is the number of channels in the second cluster.
    %
    % outputs:
    %   signals: m rows and sum(N) columns. each column is a signal. N(1)
    %   of them are correlated, N(2) of them are correlated, and these two
    %   sets are anti-correlated.
    %   r2: is the order of signals after ermuting. That is, signals(:,r2)
    %   has its first N(1) columns correlated and last N(2) columns
    %   correlated.
    %
    % Credit: Keivan Hassani Monfared, k1monfared@gmail.com
    
    if nargin < 2
        m = 1000;
    end

    
    n = sum(N); % total number of signals
    t = [1:m]'; %time steps
    r1 = randperm(n)/(.5*n); % randomized std for noise between .01 and .1
    r2 = randperm(n);
    signals = zeros(m,n); %preallocate

    for i = 1:N(1)
        signals(:,r2(i)) = sin(t) + r1(i) * randn(m,1);
    end
    for i = N(1)+1:N(1)+N(2)
        signals(:,r2(i)) = -sin(t) + r1(i) * randn(m,1);
    end
end