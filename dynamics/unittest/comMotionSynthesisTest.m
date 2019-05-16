
%% Test 1: Zero frame

mf = 0;
mb = 10;


xf = 30;
xb = -20;

xcActual =  comMotionSynthesis(xf,xb,mf,mb);

assert(isequal(xb,xcActual));

%% Test 2: Zero body


mf = 70;
mb = 0;


xf = -120;
xb = 80;

xcActual =  comMotionSynthesis(xf,xb,mf,mb);

assert(isequal(xf,xcActual));


%% Test 3: COM Equality test
% case 1
mf = 70;
mb = 3;

xf = 20;
xb = 80;

xcActual =  comMotionSynthesis(xf,xb,mf,mb);

LHS = xcActual * (mf+mb);
RHS = mf*xf + mb*xb;

assert(abs(LHS-RHS)<1e-10);
% case 2
mf = 20;
mb = 1100;

xf = -20;
xb = -37;

xcActual =  comMotionSynthesis(xf,xb,mf,mb);

LHS = xcActual * (mf+mb);
RHS = mf*xf + mb*xb;
assert(abs(LHS-RHS)<1e-10);
