

%% Test 1: Zero COM velocity and angular velocity, and zero body mass
mf = 0;
mb = 10;

xcActual = 20;
zcActual = -3.5;
phi = pi/2;
dxcActual = 0;
dzcActual = 0;
dphi = 0;

rc = 2;

[posFrame,posBody,velFrame,velBody] = pointMassMotionSynthesis(xcActual,zcActual, phi, dxcActual,dzcActual, dphi,mf,mb,rc);

assert(posBody(1)-xcActual==0);
assert(posBody(2)-zcActual==0);

assert(posBody(1)-posFrame(1)==-rc);
assert(posBody(2)-posFrame(2)==0);

assert(isequal(velFrame,zeros(2,1)));
assert(isequal(velBody,zeros(2,1)));
%% Test 2: Zero COM velocity and angular velocity, and zero frame mass
mf = 50;
mb = 0;

xcActual = 40;
zcActual = 8.5;
phi = pi/4;
dxcActual = 0;
dzcActual = 0;
dphi = 0;

rc = sqrt(2);

[posFrame,posBody,velFrame,velBody] = pointMassMotionSynthesis(xcActual,zcActual, phi, dxcActual,dzcActual, dphi,mf,mb,rc);

assert(posFrame(1)-xcActual==0);
assert(posFrame(2)-zcActual==0);

assert(posBody(1)-posFrame(1)==-1);
assert(posBody(2)-posFrame(2)==-1);

assert(isequal(velFrame,zeros(2,1)));
assert(isequal(velBody,zeros(2,1)));


%% Test 3: Zero angular velocity, and non-zero point masses
mf = 20;
mb = 20;

xcActual = 40;
zcActual = 8.5;
phi = pi;
dxcActual = -0.2;
dzcActual = 30;
dphi = 0;

rc = 0.8;

[posFrame,posBody,velFrame,velBody] = pointMassMotionSynthesis(xcActual,zcActual, phi, dxcActual,dzcActual, dphi,mf,mb,rc);

assert(abs(posFrame(1)-xcActual)<1e-10);
assert(abs(posFrame(2)-zcActual+0.4)<1e-10);

assert(abs(posBody(1)-posFrame(1))<1e-10);
assert(abs(posBody(2)-posFrame(2)-0.8)<1e-10);

assert(isequal(velFrame,[dxcActual;dzcActual]));
assert(isequal(velBody,[dxcActual;dzcActual]));

%% Test 4: Zero velocity, non zero anguler velocity
mf = 10;
mb = 50;

xcActual = 2.4;
zcActual = 0.6;
phi = 0;
dxcActual = 0;
dzcActual = 0;
dphi = 10;

rc = 6;

[posFrame,posBody,velFrame,velBody] = pointMassMotionSynthesis(xcActual,zcActual, phi, dxcActual,dzcActual, dphi,mf,mb,rc);

xf = posFrame(1);
zf = posFrame(2);

xb = posBody(1);
zb = posBody(2);

dxf = velFrame(1);
dzf = velFrame(2);

dxb = velBody(1);
dzb = velBody(2);

xc = comMotionSynthesis(xf,xb,mf,mb);
zc = comMotionSynthesis(zf,zb,mf,mb);
dxc = comMotionSynthesis(dxf,dxb,mf,mb);
dzc = comMotionSynthesis(dzf,dzb,mf,mb);

assert(abs(xc - xcActual)<1e-10);
assert(abs(zc - zcActual)<1e-10);
assert(abs(dxc - dxcActual)<1e-10);
assert(abs(dzc - dzcActual)<1e-10);



assert(abs(dzf - dzb)<1e-10);
assert(abs(dzf)<1e-10);
assert(abs(dxf-5*dphi)<1e-10);
assert(abs(dxb+1*dphi)<1e-10);

%% Test 5: All non-zero
mf = 40;
mb = 20;

xcActual = 0.4;
zcActual = 0.3;
phi = 5/4*pi;
dxcActual = 0.6;
dzcActual = -0.7;
dphi = 20;

rc = 3*sqrt(2);

[posFrame,posBody,velFrame,velBody] = pointMassMotionSynthesis(xcActual,zcActual, phi, dxcActual,dzcActual, dphi,mf,mb,rc);

xf = posFrame(1);
zf = posFrame(2);

xb = posBody(1);
zb = posBody(2);

dxf = velFrame(1);
dzf = velFrame(2);

dxb = velBody(1);
dzb = velBody(2);

xc = comMotionSynthesis(xf,xb,mf,mb);
zc = comMotionSynthesis(zf,zb,mf,mb);
dxc = comMotionSynthesis(dxf,dxb,mf,mb);
dzc = comMotionSynthesis(dzf,dzb,mf,mb);

assert(abs(xc - xcActual)<1e-10);
assert(abs(zc - zcActual)<1e-10);
assert(abs(dxc - dxcActual)<1e-10);
assert(abs(dzc - dzcActual)<1e-10);


assert(abs(dzf - (dzcActual +dphi*1))<1e-10);
assert(abs(dxf- (dxcActual -dphi*1))<1e-10);
assert(abs(dzb - (dzcActual -dphi*2 ))<1e-10);
assert(abs(dxb - (dxcActual +dphi*2 ))<1e-10);
% 