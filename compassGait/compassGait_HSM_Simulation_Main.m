%MAIN  --  trajectory optimization
%
% This script sets up a trajectory optimization problem for solving the motion 
% for a compass gait robot.



clc;
% clear;
close all;

%% ToDo



%% Add Path

addpath(genpath('function')); %%

%%
%%
% close all;

nNodes = parms.totalKnotNumber;

q1 = q(1,:);
q2 = q(2,:);

stepTime = h/2*(nNodes-1);
parms.tF = stepTime;
t = linspace(0,stepTime,nNodes);

disp('curve fitting for desired trajectory...')
polyOrder = 10;
polyp = polyfit(t,q1-q2,polyOrder);
polyv = polyp(1:polyOrder).*(polyOrder:-1:1);
polya = polyp(1:polyOrder-1).*(polyOrder-1:-1:1);

parms.polyp = polyp;
parms.polyv = polyv;
parms.polya = polya;

disp('coefficient of desired trajectory generated...')
%%
% initial condition
q0 = q(:,1);
dq0 = dq(:,1);
% q0 = [0.203178686826606;-0.303360585891081];
% dq0 = [-1.19656127282449;-0.720510081772477];
% q0 = [0.216906738954957;-0.317088638019432];
% dq0 = [-1.08446881498719;-0.397441732888411];
psi = 2.87/180*pi;

        CalcEom=@(t,x)calcEOM(t,x,parms);    
        event = @(t,x)eventsFcn(t,x,psi);
        options = odeset('Events',event);
        tspan = 0:0.01:2;
    
        for i = 1:20
        [ret_t,ret_x,~]=ode45(CalcEom,tspan,[q0;dq0], options);
        
        q1 = ret_x(end,1);
        q2 = ret_x(end,2);
        
        dq1 = ret_x(end,3);
        dq2 = ret_x(end,4);
        
        q0 = [0 1 ;1 0 ]*[q1;q2];
        dq0 = delta(q1,q2)*[dq1;dq2];
        
        plot(ret_x(:,1),ret_x(:,3),'b')
        hold on
        plot(ret_x(:,2),ret_x(:,4),'r')
        fprintf("%dth step, step time = %.3f\n",i,ret_t(end))
        end
        
        plot(q(1,:),dq(1,:))
        hold on 
        plot(q(2,:),dq(2,:))
        hold off
        title('phase portrait vs. optimization result')
        xlabel('rad')
        ylabel('rad/s')        
        
        figure()
        plot(t, q(1,:)-q(2,:))
        hold on 
        plot(ret_t, ret_x(:,1)-ret_x(:,2))
        xlabel('time')
        ylabel('y = q_1-q_2(rad)')
        legend('y_d','y_a')
        
function dx =  calcEOM(t,x,p)
    q1 = x(1);
    q2 = x(2);
    dq1 = x(3);
    dq2 = x(4);
    
    %% controller design
wn = 3;
kp = wn^2;
kd = 2*wn;

Jy = [1 -1]; %ya =q1-q2;
ya = q1 -q2;
dya = dq1 -dq2;

tau = t;
if t>=p.tF 
    tau = p.tF ;
end
fx = fx_active(dq1,dq2,q1,q2);
gx = gx_active(q1,q2);

% if strcmp(p.ctrl,'IO')
    yd = polyval(p.polyp,tau);
    dyd = polyval(p.polyv,tau);
    ddyd = polyval(p.polya,tau);

    y2 = ya-yd;
    dy2 = dya-dyd;
    
    u = (Jy*gx)\(Jy*fx+ddyd-kp*y2-kd*dy2);
%     u = 0;
    
    dx = zeros(4,1);
    
    dx(1) = dq1;
    dx(2) = dq2;
    dx(3:4) = dym_active(dq1,dq2,q1,q2,u);
    
%     [ddq1,ddq2] = autoGen_dynamics(q1,q2,dq1,dq2,u,p.d,p.m,p.I,p.g,p.l);
end
function [position,isterminal,direction] = eventsFcn(t,x,psi)
    position =  cos(x(1) + psi) - cos(x(2) + psi);
    isterminal = 1;  % Halt integration 
    direction = -1;
end