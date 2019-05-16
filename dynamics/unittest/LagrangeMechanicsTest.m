
%% Test 1: Simple Pendulum
%
% Reference
% https://ocw.mit.edu/courses/mechanical-engineering/2-003j-dynamics-and-control-i-spring-2007/lecture-notes/lec16.pdf

syms theta dtheta ddtheta
syms m g l

T = 1/2*m*l^2*dtheta^2;
V = - m*g*l*cos(theta);

xVec = theta;
dxVec = dtheta;
ddxVec = ddtheta;

[Mmat,bvec] = LagrangeMechanics(T,V,xVec,dxVec,ddxVec);

MmatReal = m*l^2;

bvecReal = -m*g*l*sin(theta);
        
assert(isequaln(simplify(Mmat-MmatReal),sym(zeros(1,1))));
assert(isequaln(simplify(bvec-bvecReal),sym(zeros(1,1))));

%% Test 2: Cart with Pendulum and Spring
%
% Reference
% https://ocw.mit.edu/courses/mechanical-engineering/2-003j-dynamics-and-control-i-spring-2007/lecture-notes/lec16.pdf

syms x dx s ds theta dtheta ddx  ddtheta dds
syms m k g l M

T = 1/2*M*dx^2 + 1/2*m*((dx+ds*sin(theta)+s*cos(theta)*dtheta)^2 +(s*sin(theta)*dtheta-ds*cos(theta))^2);
V = - m*g*s*cos(theta) + 1/2*k*(s-l)^2;

xVec = [x;theta;s];
dxVec = [dx;dtheta;ds];
ddxVec = [ddx;ddtheta;dds];

[Mmat,bvec] = LagrangeMechanics(T,V,xVec,dxVec,ddxVec);

MmatReal =[M+m, m*s*cos(theta), m*sin(theta); 
           m*s*cos(theta)  , m*s^2, 0  ;
           m*sin(theta),  0, m   ];
bvecReal = [-m*ds*dtheta*cos(theta)*2+m*s*dtheta^2*sin(theta);
            -m*s*g*sin(theta)-2*m*s*ds*dtheta;
            m*s*dtheta^2+m*g*cos(theta)-k*(s-l)];
        
assert(isequaln(simplify(Mmat-MmatReal),sym(zeros(3,3))));
assert(isequaln(simplify(bvec-bvecReal),sym(zeros(3,1))));


%% Test 3: SLIP model
%
% Reference
% Z. Shen et al., “A Piecewise-Linear Approximation of the Canonical 
% Spring-Loaded Inverted Pendulum Model of Legged Locomotion,” J. Comput. 
% Nonlinear Dyn., vol. 11, no. 1, 2016.

syms l dl theta dtheta ddl ddtheta
syms m k g l0
dx = -dl*cos(theta)+l*sin(theta)*dtheta;
dz = dl*sin(theta)+l*cos(theta)*dtheta;

T = 1/2*m*(dx^2 + dz^2);
V = 1/2*k*(l-l0)^2 + m*g*l*sin(theta);

xVec = [l;theta];
dxVec = [dl;dtheta];
ddxVec = [ddl;ddtheta];

[Mmat,bvec] = LagrangeMechanics(T,V,xVec,dxVec,ddxVec);

MmatReal = [m, 0;0, m*l^2];

bvecReal = [-m*g*sin(theta)-k*l+k*l0+m*l*dtheta^2;...
            -m*g*l*cos(theta)-2*m*l*dl*dtheta];
        
assert(isequaln(simplify(Mmat-MmatReal),sym(zeros(2,2))));
assert(isequaln(simplify(bvec-bvecReal),sym(zeros(2,1))));