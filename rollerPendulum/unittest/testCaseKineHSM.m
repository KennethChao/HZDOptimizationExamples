function funcs = testCaseKineHSM(parms)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
funcs = {};
funcs.objective = @(x) 0;
funcs.gradient = @(x)  zeros(1,parms.totalVarNumber);
funcs.constraints = @(x)cKine(x, parms);
funcs.jacobian = @(x)gcKine(x, parms);
funcs.jacobianstructure =@()gcKinePattern(parms);
funcs.type = 'KineHSM';
end

function c = cKine(xVec, parms)
[q, dq, ddq, u, h, relaxation] = extractState(xVec, parms);
c = constKineHSM(q,dq,ddq,h,parms);
end %function end

function g = gcKine(xVec, parms)
[q, dq, ddq, u, h, relaxation] = extractState(xVec, parms);
g=gconstKineHSM(q,dq,ddq,h,parms);
end %function end
%
function G = gcKinePattern(parms)
G = gconstKineHSMPattern(parms);
end

