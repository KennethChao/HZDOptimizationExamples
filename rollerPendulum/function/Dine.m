function dym = Dine(ddq1,ddq2,dq1,dq2,q2,u)
%DINE
%    DYM = DINE(DDQ1,DDQ2,DQ1,DQ2,Q2,U)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    02-Apr-2019 20:44:17

t2 = sin(q2);
t3 = cos(q2);
dym = [ddq1.*(3.1e1./1.0e3)+dq1./1.0e1-u-ddq2.*t3.*(3.0./5.0e2)-dq2.^2.*t2.*(3.0./5.0e2);ddq2.*(3.0./1.25e2)-t2.*5.886e-1-ddq1.*t3.*(3.0./5.0e2)];
