function gOutput = gDine(ddq1,ddq2,dq2,q2)
%GDINE
%    GOUTPUT = GDINE(DDQ1,DDQ2,DQ2,Q2)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    02-Apr-2019 20:44:17

t2 = sin(q2);
t3 = cos(q2);
gOutput = reshape([0.0,0.0,ddq2.*t2.*(3.0./5.0e2)-dq2.^2.*t3.*(3.0./5.0e2),t3.*(-5.886e-1)+ddq1.*t2.*(3.0./5.0e2),1.0./1.0e1,0.0,dq2.*t2.*(-3.0./2.5e2),0.0,3.1e1./1.0e3,t3.*(-3.0./5.0e2),t3.*(-3.0./5.0e2),3.0./1.25e2,-1.0,0.0],[2,7]);
