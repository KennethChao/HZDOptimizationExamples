
%% Roller with Pendulum
%
% Reference
% https://ocw.mit.edu/courses/mechanical-engineering/2-003j-dynamics-and-control-i-spring-2007/lecture-notes/lec16.pdf
addpath(genpath('../../dynamics/util'))
syms q1 dq1 ddq1 q2 dq2 ddq2 u real
syms m k g l M

I0 = 0.024;
I1 = 0.006;
m0 = 0.5;
m1 = 0.2;
R = 0.1;
b = 0.1;
g = 9.81;
l = 0.3;

% T = 0.5*(I0 + (m0+m1)*R**2)*q[2]**2 - m1*l*R*q[2]*q[3]*cos(q[1]) + 0.5*(I1 + m1*l**2)*q[3]**2
T = 1/2*(I0 + (m0+m1)*R^2)*dq1^2 - m1*l*R*dq1*dq2*cos(q2) + 1/2*(I1 + m1*l^2)*dq2^2;
% V = m1*g*l*(1 - cos(q[1]))
V = m1*g*l*(1-cos(q2));

xVec = [q1; q2];
dxVec = [dq1; dq2];
ddxVec = [ddq1; ddq2];

[Mmat,bvec] = LagrangeMechanics(T,V,xVec,dxVec,ddxVec);

input = [-b*dq1+ u; 0];
dym = Mmat*ddxVec + bvec -input;

matlabFunction(dym,'File','Dine');

%% Gradient of EOM
gOutput1 = gradient(dym(1,1), [q1 q2 dq1 dq2 ddq1 ddq2 u])';
gOutput2 = gradient(dym(2,1), [q1 q2 dq1 dq2 ddq1 ddq2 u])';

% Export gDine
gOutput = [gOutput1;gOutput2];
matlabFunction(gOutput,'File','gDine');


gOutputPattern = gOutput;
gOutputPattern(gOutputPattern~=0)=1


%% fx

fx = Mmat^-1*(input-bvec);
matlabFunction(fx,'File','fx');

fx2 = bvec + [b*dq1;0];
matlabFunction(fx2,'File','getFeedForwardTorque');

% Mmat
matlabFunction(Mmat,'File','Mmat');


