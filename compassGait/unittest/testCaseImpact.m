function funcs = testCaseImpact(parms)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
funcs = {};
funcs.objective = @(x) 0;
funcs.gradient = @(x)  zeros(1,parms.totalVarNumber);
funcs.constraints = @(x)cImpact(x, parms);
funcs.jacobian = @(x)gcImpact(x, parms);
funcs.jacobianstructure =@()gcImpactPattern(parms);
funcs.type = 'Impact';
end


function c = cImpact(xVec, parms)
c = constImpact(xVec, parms);
end %function end

function g = gcImpact(xVec, parms)
g=gconstImpact(xVec, parms);
end %function end

function G = gcImpactPattern(parms)
G = gconstImpactPattern(parms);
end
