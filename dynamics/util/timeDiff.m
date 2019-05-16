function dexpr =  timeDiff(expr,x,xd,xdd)  
%TIMEDIFF Calculate the time derivative symbolically w.r.t to state variables
%   This function can calculate the time derivative of a expression as a
%   function of x and/or xd. The time derivative is calculated by chain
%   rule: 
%   
%   d f(x)/dt = d f(x)/dx * dx/dt
%
%   Implemented for the fixed point finder of SLIP-based runners.
%   2018, IHMC

gx = [x;xd];
dgx = [xd;xdd];

dim = length(x);
for i = 1:dim
    dexpr = jacobian(expr,gx)*dgx;
end

end