%MAIN  --  trajectory optimization
%
% This script sets up a trajectory optimization problem for solving the motion 
% for block moving.

% In line 29 & 30, costFunctionType determines the optimization for different 
% objective function:
% 'minNorm' solves the optimal trajectory with min-norm control (fixed terminal time).
% 'timeOptimal' solves time-optimal trajectory with constrained control.


clc;
clear;
close all;

%% ToDo
% 1. kine_symbolic end-effector position
% 2. step length and velocity constraint
% 3. foot clearance constraint


%% Add Path
addpath(genpath('const')); %%
addpath(genpath('cost')); %%
addpath(genpath('function')); %%
addpath(genpath('unittest')); %%

%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                  Parameters for the dynamics function                   %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

costFunctionType = 'others';

parms = trajOptConfig(costFunctionType);


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                       Set up function handles                           %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

% trajOpt for motion
[funcs, parms] = optFunctionHandles_AllCnst_fmincon(parms);


% unittest for gradient check
% funcs = testCaseKineHSM(parms);
% funcs = testCaseCost(parms);
% funcs = testCaseDym(parms);
% funcs = testCaseImpact(parms); %Periodic (velocity via impact map)
% funcs = testCasePeriodic(parms); %Periodic (position)
%  funcs = testCaseBoundary(parms);% Position and Velocity

% funcs = testCaseFootClearance(parms); % Position


%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%               Set up bounds on time, state, and control                 %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
[lb, ub] = inputBounds(parms);
% [clb, cub] = constBounds(parms,funcs.type);

% options.lb = lb;
% options.ub = ub;
% options.cl = clb;
% options.cu = cub;

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%              Create an initial guess for the trajectory                 %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
load('goodInitialGuess.mat')
% xVec = rand(parms.totalVarNumber,1);
% [q, dq, ddq, u,  h, relaxation] = extractState(xVec, parms);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                           IPOPT options:                                %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
Aeq = funcs.Aeq(xVec);
beq = zeros(size(Aeq,1),1);


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                           Solve!                                        %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
options = optimoptions('fmincon','Display','iter','PlotFcn','optimplotfval')
options.MaxFunctionEvaluations = 10^10;
x_Flat2 = fmincon(funcs.objective,xVec,[],[],Aeq,beq,lb,ub,funcs.constraints,options);

[q, dq, ddq, u, h, relaxation] = extractState(x_Flat2, parms);

figure()
plot(q','DisplayName','x')
ylabel('position')

figure()
plot(dq','DisplayName','x')
ylabel('velocity')

figure()
plot(u','DisplayName','u')
ylabel('control input')

