%MAIN  --  trajectory optimization
%
% This script sets up a trajectory optimization problem for solving the motion 
% for block moving.

% In line 29 & 30, costFunctionType determines the optimization for different 
% objective function:
% 'minNorm' solves the optimal trajectory with min-norm control (fixed terminal time).
% 'timeOptimal' solves time-optimal trajectory with constrained control.


clc;
% clear;
close all;

%% ToDo
polyOrder = 5;
tStamp = linspace(0,1,size(q,2));
qCoef = polyfit(tStamp,q(2,:),polyOrder);
dqCoef = polyfit(tStamp,dq(2,:),polyOrder);

parmsSim.qCoef = qCoef;
parmsSim.dqCoef = dqCoef;
parmsSim.kp = 30;
parmsSim.kd = 10;
parmsSim.mode = 'odeSolver';

%% Add Path

addpath(genpath('function')); %%

        CalcEom=@(t,x)calcEOM(t,x,parmsSim);    
        q0 = [0;parms.initialAngle];
        dq0 = [0;0];
        tspan = 0:0.01:1;
        
        [ret_t,ret_x,~]=ode45(CalcEom,tspan,[q0;dq0], options);
        
        parmsSim.mode = 'controlInput';
        ret_u = getControlInput(ret_t,ret_x,parmsSim);
        
        linewidth = 2;
        
        plot(ret_t,ret_x(:,1:2),'linewidth',linewidth);        
        hold on
        plot(tStamp,q,'linewidth',linewidth);
        hold off
        xlabel('time')
        ylabel('q(rad)')
        legend('q1_a','q2_a','q1_d','q2_d')
        
        figure()
        plot(ret_t,ret_x(:,3:4),'linewidth',linewidth);        
        hold on
        plot(tStamp,dq,'linewidth',linewidth);
        hold off     
        xlabel('time')
        ylabel('q_dot(rad/s)')
        legend('dq1_a','dq2_a','dq1_d','dq2_d')

        figure()
        plot(ret_t,ret_u,'linewidth',linewidth);        
        hold on
        plot(tStamp,u,'linewidth',linewidth);
        hold off     
        xlabel('time')
        ylabel('u(Nm)')
        legend('u_a','u_d')
        
function dx =  calcEOM(t,x,parmsSim)

    kp = parmsSim.kp;
    kd = parmsSim.kd;
    
    qCoef = parmsSim.qCoef;
    dqCoef = parmsSim.dqCoef;

    q1 = x(1);
    q2 = x(2);
    dq1 = x(3);
    dq2 = x(4);
    
    
    
    q2d = polyval(qCoef,t);
    dq2d = polyval(dqCoef,t);
    
%     u = getFeedForwardTorque(dq1,dq2,q2) +  (q2-q2d)*kp + (dq2 - dq2d)*kd;
    u = (q2-q2d)*kp + (dq2 - dq2d)*kd;
    
    if strcmp(parmsSim.mode,'odeSolver')
    dx = zeros(4,1);
    dx(1) = dq1;
    dx(2) = dq2;
    dx(3:4) = fx(dq1,dq2,q2,u);
    elseif strcmp(parmsSim.mode,'controlInput')
    dx = u;
    end
    
end

function u = getControlInput(ret_t,ret_x,parms)
    u= zeros(length(ret_t),1);
    for i = 1:length(ret_t)
        u(i) = calcEOM(ret_t(i),ret_x(i,:),parms);    
    end
end

  