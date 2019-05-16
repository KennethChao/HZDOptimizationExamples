function [funcs, parms] = optFunctionHandles_AllCnst(parms)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
% parms.costMode = 'COTwithKneePenalty';

cost = @(x)costFunction(x, parms); 
gCost = @(x)gcostFunction(x, parms); 
%
cnst = @(x)constAll(x, parms);
gCnst = @(x)gconstAll(x, parms);
%
cnstPattern = @()GP(parms);

% Assign Function Handle for IPOPT
funcs.objective = cost;
funcs.gradient = gCost;
funcs.constraints = cnst;
funcs.jacobian = gCnst;
funcs.jacobianstructure =cnstPattern;
funcs.type = 'All';
    
end

function c = costFunction(xVec, parms)
[q, dq, ddq, u,  h, relaxation] = extractState(xVec, parms);
%
c = costFun(q,dq,u, h, relaxation,parms);
end %function end

function g = gcostFunction(xVec, parms)
[q, dq, ddq, u,  h, relaxation] = extractState(xVec, parms);
%
g = gcostFun(q,dq,u, h, relaxation,parms);

end %function end

function c = constAll(xVec, parms)
[q, dq, ddq, u,  h, relaxation ] = extractState(xVec, parms);

c0 = constKineHSM(q,dq,ddq,h,parms);
c1 = constDym(xVec, parms);
c = [c0; c1];    
end %function end

function g = gconstAll(xVec, parms)
[q, dq, ddq, u,  h, relaxation ] = extractState(xVec, parms);
g0 = gconstKineHSM(q,dq,ddq,h,parms);
g1 = gconstDym(xVec, parms);
g = [g0;g1];
end %function end

function Pattern = GP(parms)
G0 = gconstKineHSMPattern(parms);
G1 = gconstDymPattern(parms);
Pattern = [G0;G1];
end

