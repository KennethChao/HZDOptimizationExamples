function [funcs, parms] = optFunctionHandles_AllCnst_fmincon(parms)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
% parms.costMode = 'COTwithKneePenalty';

cost = @(x)costFunction(x, parms); 
AeqMat = @(x)linearEqConst(x, parms);
% gCost = @(x)gcostFunction(x, parms); 
% %
cnst = @(x)constAll(x, parms);
% gCnst = @(x)gconstAll(x, parms);
% %
% cnstPattern = @()GP(parms);

% Assign Function Handle for IPOPT
funcs.objective = cost;
funcs.Aeq = AeqMat;
% funcs.gradient = gCost;
funcs.constraints = cnst;
% funcs.jacobian = gCnst;
% funcs.jacobianstructure =cnstPattern;
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

function Aeq = linearEqConst(xVec, parms)
Aeq = gconstPeriodic(xVec, parms);
end
function [c,ceq] = constAll(xVec, parms)
[q, dq, ddq, u,  h, relaxation] = extractState(xVec, parms);
c0 = constKineHSM(q,dq,ddq,h,parms);
c1 = constDym(xVec, parms);
c2 = constImpact(xVec, parms);
c3 = constBoundary(xVec, parms);
c = [-c3(2);
     c3(3);    
     -c3(4)+parms.stepLength;];
ceq = [c0; c1; c2; c3(1)];
end
% function c = constAll(xVec, parms)
% [q, dq, ddq, u,  h, relaxation ] = extractState(xVec, parms);
% 
% c0 = constKineHSM(q,dq,ddq,h,parms);
% c1 = constDym(xVec, parms);
% c2 = constImpact(xVec, parms);
% c3 = constPeriodic(xVec, parms);
% c4 = constBoundary(xVec, parms);
% c = [c0; c1; c2; c3; c4];    
% end %function end
% 
% function g = gconstAll(xVec, parms)
% [q, dq, ddq, u,  h, relaxation ] = extractState(xVec, parms);
% g0 = gconstKineHSM(q,dq,ddq,h,parms);
% g1 = gconstDym(xVec, parms);
% g2 = gconstImpact(xVec, parms);
% g3 = gconstPeriodic(xVec, parms);
% g4 = gconstBoundary(xVec, parms);
% g = [g0;g1;g2;g3;g4];
% end %function end
% 
% function Pattern = GP(parms)
% G0 = gconstKineHSMPattern(parms);
% G1 = gconstDymPattern(parms);
% G2 = gconstImpactPattern(parms);
% G3 = gconstPeriodicPattern(parms);
% G4 = gconstBoundaryPattern(parms);
% Pattern = [G0;G1;G2;G3;G4];
% end

