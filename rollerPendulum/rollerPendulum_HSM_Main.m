%MAIN  --  trajectory optimization
%
% This script sets up a trajectory optimization problem for solving the motion 
% for roller pendulum model.

% In line 29 & 30, costFunctionType determines the optimization for different 
% objective function:
% 'minNorm' solves the optimal trajectory with min-norm control (fixed terminal time).
% 'timeOptimal' solves time-optimal trajectory with constrained control.


clc;
clear;
close all;

%% ToDo



%% Add Path
addpath(genpath('const')); %%
addpath(genpath('cost')); %%
addpath(genpath('function')); %%
addpath(genpath('unittest')); %%

%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                  Parameters for the dynamics function                   %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

costFunctionType = 'minNorm';
% costFunctionType = 'timeOptimal';

parms = trajOptConfig(costFunctionType);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                       Set up function handles                           %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

% trajOpt for motion
[funcs, parms] = optFunctionHandles_AllCnst(parms);


% unittest for gradient check
% funcs = testCaseKineHSM(parms);
% funcs = testCaseCost(parms);
% funcs = testCaseDym(parms);



%%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%               Set up bounds on time, state, and control                 %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
[lb, ub] = inputBounds(parms);
[clb, cub] = constBounds(parms,funcs.type);

options.lb = lb;
options.ub = ub;
options.cl = clb;
options.cu = cub;

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%              Create an initial guess for the trajectory                 %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
% xVec = rand(parms.totalVarNumber,1);
% load('good_initialGuess.mat')

lineTraj = linspace(parms.initialAngle,parms.targetAngle,parms.totalKnotNumber);
q = [lineTraj;lineTraj;];
dq = [lineTraj;lineTraj;];
ddq = [lineTraj;lineTraj;];
u = [lineTraj];
h = 1;
relaxation = 1;
xVec = state2FreeVariableVector(q, dq, ddq, u,h, relaxation, parms)

% [q, dq, ddq, u,  h, relaxation] = extractState(xVec, parms);

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                           IPOPT options:                                %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
options.ipopt.hessian_approximation = 'limited-memory';
% options.ipopt.tol = 1e-3;
% options.ipopt.acceptable_tol = 1e-2;
options.ipopt.mu_strategy = 'adaptive';

options.ipopt.print_info_string = 'yes';
% options.ipopt.linear_solver = 'ma57';

% Options for gradient check
% options.ipopt.derivative_test       = 'first-order';
% options.ipopt.max_iter = 1;


%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                           Solve!                                        %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%

[x_Flat2, ~] = ipopt(xVec,funcs,options);

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

function xVec = state2FreeVariableVector(q, dq, ddq, u,h, relaxation, parms)
%STATE2FREEVARIABLEVECTOR Encode the free varaibles to a single vector for opt purpose.
%

xVec = zeros(parms.totalVarNumber, 1);
for i = 1:parms.totalKnotNumber
    xSegment = [q(:, i); ...
        dq(:, i); ...
        ddq(:, i); ...
        u(:, i); ...
        ];
    xVec((i - 1)*parms.nVarSeg+(1:parms.nVarSeg), 1) = xSegment;
end

for i = 1:parms.phaseNum
    xVec(end-i) = h(i);
end
xVec(end) = relaxation;
end