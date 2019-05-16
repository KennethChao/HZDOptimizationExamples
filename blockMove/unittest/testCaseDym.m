function funcs = testCaseDym(parms)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
funcs = {};
funcs.objective = @(x) 0;
funcs.gradient = @(x)  zeros(1,parms.totalVarNumber);
funcs.constraints = @(x)cDym(x, parms);
funcs.jacobian = @(x)gcDym(x, parms);
funcs.jacobianstructure =@()gcDymPattern(parms);
funcs.type = 'Dym';
end


function c = cDym(xVec, parms)
c = constDym(xVec, parms);
end %function end

function g = gcDym(xVec, parms)
g=gconstDym(xVec, parms);
end %function end

function G = gcDymPattern(parms)
G = gconstDymPattern(parms);
end
