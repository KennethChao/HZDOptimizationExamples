function funcs = testCaseBoundary(parms)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
funcs = {};
funcs.objective = @(x) 0;
funcs.gradient = @(x)  zeros(1,parms.totalVarNumber);
funcs.constraints = @(x)cBoundary(x, parms);
funcs.jacobian = @(x)gcBoundary(x, parms);
funcs.jacobianstructure =@()gcBoundaryPattern(parms);
funcs.type = 'Boundary';
end


function c = cBoundary(xVec, parms)
c = constBoundary(xVec, parms);
end %function end

function g = gcBoundary(xVec, parms)
g=gconstBoundary(xVec, parms);
end %function end

function G = gcBoundaryPattern(parms)
G = gconstBoundaryPattern(parms);
end
