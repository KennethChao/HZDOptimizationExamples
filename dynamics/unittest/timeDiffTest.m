
%% Test 1: Cart with Pendulum and Spring
%
% Reference
% https://ocw.mit.edu/courses/mechanical-engineering/2-003j-dynamics-and-control-i-spring-2007/lecture-notes/lec16.pdf

syms x dx s ds theta dtheta ddx  ddtheta dds
syms m k g l M

xm = x+s*sin(theta);
dxmActual = dx+ds*sin(theta)+s*cos(theta)*dtheta;

ym = -s*cos(theta);
dymActual = -ds*cos(theta)+s*sin(theta)*dtheta;

xVec = [x;theta;s];
dxVec = [dx;dtheta;ds];
ddxVec = [ddx;ddtheta;dds];

dxm =  timeDiff(xm,xVec,dxVec,ddxVec);
dym =  timeDiff(ym,xVec,dxVec,ddxVec);

assert(isequaln(simplify(dxm-dxmActual),sym(zeros(1,1))));
assert(isequaln(simplify(dym-dymActual),sym(zeros(1,1))));


%% Test 2: SLIP model
%
% Reference
% Z. Shen et al., “A Piecewise-Linear Approximation of the Canonical 
% Spring-Loaded Inverted Pendulum Model of Legged Locomotion,” J. Comput. 
% Nonlinear Dyn., vol. 11, no. 1, 2016.

syms l dl theta dtheta ddl ddtheta
syms m k g l0
x = -l*cos(theta);
z = l*sin(theta);

dxActual = -dl*cos(theta)+l*sin(theta)*dtheta;
dzActual = dl*sin(theta)+l*cos(theta)*dtheta;


xVec = [l;theta];
dxVec = [dl;dtheta];
ddxVec = [ddl;ddtheta];

dx =  timeDiff(x,xVec,dxVec,ddxVec);
dz =  timeDiff(z,xVec,dxVec,ddxVec);

assert(isequaln(simplify(dx-dxActual),sym(zeros(1,1))));
assert(isequaln(simplify(dz-dzActual),sym(zeros(1,1))));

%% Test 3: SLIP with PEndulum Runner (SLIPPER)
%
% Reference
% [1] Z. Shen et al., “A Piecewise-Linear Approximation of the Canonical 
% Spring-Loaded Inverted Pendulum Model of Legged Locomotion,” J. Comput. 
% Nonlinear Dyn., vol. 11, no. 1, 2016.
% [2] Note of fast runner project, Ken Chao, IHMC, 2018.

syms l dl theta dtheta phi dphi ddl ddtheta ddphi
syms m k g l0 rc
x = -l*cos(theta) -rc*sin(phi);
z = l*sin(theta) -rc*cos(phi);

dxActual = -dl*cos(theta)+l*sin(theta)*dtheta - rc*cos(phi)*dphi;
dzActual = dl*sin(theta)+l*cos(theta)*dtheta + rc*sin(phi)*dphi;


xVec = [l;theta;phi];
dxVec = [dl;dtheta;dphi];
ddxVec = [ddl;ddtheta;ddphi];

dx =  timeDiff(x,xVec,dxVec,ddxVec);
dz =  timeDiff(z,xVec,dxVec,ddxVec);

assert(isequaln(simplify(dx-dxActual),sym(zeros(1,1))));
assert(isequaln(simplify(dz-dzActual),sym(zeros(1,1))));