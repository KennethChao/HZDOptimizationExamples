function funcs = testCaseCost(parms)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
%COTwithKneePenalty
funcs = {};
funcs.objective = @(x)costFunction(x, parms);
funcs.gradient = @(x)gcostFunction(x, parms);
funcs.type = 'Cost';
end

function c = costFunction(xVec, parms)
[q, dq, ddq, u, h, relaxation] = extractState(xVec, parms);
%
c = costFun(q,dq,u, h, relaxation,parms);
end %function end

function g = gcostFunction(xVec, parms)
[q, dq, ddq, u, h, relaxation] = extractState(xVec, parms);
%
g = gcostFun(q,dq,u, h, relaxation,parms);

end %function end

