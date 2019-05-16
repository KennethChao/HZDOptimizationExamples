function funcs = testCasePeriodic(parms)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
funcs = {};
funcs.objective = @(x) 0;
funcs.gradient = @(x)  zeros(1,parms.totalVarNumber);
funcs.constraints = @(x)cPeriodic(x, parms);
funcs.jacobian = @(x)gcPeriodic(x, parms);
funcs.jacobianstructure =@()gcPeriodicPattern(parms);
funcs.type = 'Periodic';
end


function c = cPeriodic(xVec, parms)
c = constPeriodic(xVec, parms);
end %function end

function g = gcPeriodic(xVec, parms)
g=gconstPeriodic(xVec, parms);
end %function end

function G = gcPeriodicPattern(parms)
G = gconstPeriodicPattern(parms);
end
