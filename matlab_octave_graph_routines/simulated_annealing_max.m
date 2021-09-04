function [x0,f0]=simulated_annealing_max(f,A,x0,Mmax,TolFun)
%sim_anl maximizes a function with the method of simulated annealing (Kirkpatrick et al., 1983) [1]
% 
% 
% INPUTS: 
%        f = the cost function
%        A = the adjacency matrix or any other matrix for that matter
%        x0 = an initial guess for the minimun
%        Mmax = maximun number of temperatures
%        TolFun = tolerancia de la función
%
%
% OUTPUTS: 
%        x0 = candidate to global minimun founded
%        f0 = value of function on x0
%
%
% Example [2]:
%
%  this code works with it as follows:
%  C = 1:16;
%  f = @girvan_newman_modularity;
%  initial = random_bipartition(C);
%  [C0,Q0]=simulated_annealing(f,A,initial,400);
%
%  References:
%  [1] Kirkpatrick, S., Gelatt, C.D., & Vecchi, M.P. (1983). Optimization by
%      Simulated Annealing. _Science, 220_, 671-680.
%
%  [2] Joachim Vandekerckhove, General simulated annealing algorithm, Taken on the 30th of September 2011.
%      http://www.mathworks.de/matlabcentral/fileexchange/10548
%
%
%  [3] Won Y. Yang, Wenwu Cao, Tae-Sang Chung, John Morris, "Applied
%      Numerical Methods Using MATLAB", John Whiley & Sons, 2005
%
%
%  [4] 1108 - Troubleshooting Common Floating-Point Arithmetic Problems. Taken on the 3th of October 2011.
%      http://www.mathworks.es/support/tech-notes/1100/1108.html
%
%  [5] Peter N. Saeta, The Metropolis Algorithm. Taken on the 3th of October 2011.
%      http://kossi.physics.hmc.edu/courses/p170/Metropolis.pdf
%
%
%This function was written by :
%                             Héctor Corte
%And editted by:
%                Keivan Hassani Monfared (k1monfared@gmail.com)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<5
   TolFun=1e-4;
   if nargin<4
       Mmax=100;
   end
end
%x0 is the current solution point and f0=f(x0).
%x is the current point and fx=f(x)
%x1 is the test point and fx1=f(x1)
%Our initial current point will be the current solution point
x=x0;
fx=f(A,x);
f0=fx;
%Main loop simulates de annealing from a high temperature to zero in Mmax iterations.
for m=0:Mmax
    %We calculate T as the inverse of temperature.
    %Boltzman constant = 1
    T=m/Mmax; 
    %For each temperature we take 500 test points to simulate reach termal
    %equilibrium.
    for k=0:500        
        %We generate new test point by randomly moving an element of a
        %cluster to another one
        
        %%%%%%%% Main function call %%%%%%%%%%%%%
        x1= new_config_from(x);
        
        
        
        
        %We evaluate the function and the change between test point and
        %current point
        fx1=f(A,x1);df=fx1-fx;
        %If the function variation,df, is <0 we take test point as current
        %point. And if df>0 we use Metropolis [5] condition to accept or
        %reject the test point as current point.
        %We use eps and TolFun to adjust temperature [4].        
        if (df > 0 || rand < exp(-T*df/(abs(fx)+eps)/TolFun))== 1
            x=x1;fx=fx1;
        end        
        %If the current point is better than current solution, we take
        %current point as cuyrrent solution.       
        if fx1 > f0 ==1
        x0=x1;f0=fx1;
        end   
    end
end
end