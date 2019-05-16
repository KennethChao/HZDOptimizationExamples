function fx = dym_active(dq1,dq2,q1,q2,u)
%DYM_ACTIVE
%    FX = DYM_ACTIVE(DQ1,DQ2,Q1,Q2,U)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    24-Apr-2019 00:10:47

t3 = q1-q2;
t2 = cos(t3);
t4 = t2.^2;
t5 = t4.*4.0;
t6 = t5-1.3e1;
t7 = 1.0./t6;
t8 = sin(t3);
t9 = sin(q2);
t10 = t9.*(9.81e2./4.0e1);
t11 = dq1.^2;
t12 = t8.*t11.*(5.0./2.0);
t13 = t10+t12+u;
t14 = sin(q1);
t15 = t14.*1.71675e2;
t16 = dq2.^2;
t17 = t8.*t16.*(5.0./2.0);
t18 = t15+t17+u;
fx = [t7.*t18.*(-4.0./5.0)+t2.*t7.*t13.*(8.0./5.0);t7.*t13.*(5.2e1./5.0)-t2.*t7.*t18.*(8.0./5.0)];
