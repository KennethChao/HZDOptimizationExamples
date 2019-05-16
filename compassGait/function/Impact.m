function impactOutput = Impact(dq1,dq2,dq1_plus,dq2_plus,q1,q2)
%IMPACT
%    IMPACTOUTPUT = IMPACT(DQ1,DQ2,DQ1_PLUS,DQ2_PLUS,Q1,Q2)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    24-Apr-2019 00:10:46

t3 = q1-q2;
t2 = cos(t3);
t4 = t2.^2;
t5 = t4.*4.0;
t6 = t5-1.3e1;
t7 = 1.0./t6;
t8 = t2.*2.0;
t9 = t2.*1.5e1;
t10 = t9-5.0./4.0;
impactOutput = [dq1_plus+dq1.*(t7.*t10.*(4.0./5.0)-t7.*(t8-1.0))-dq2.*t7;dq2_plus+dq1.*(t7.*(t8-1.3e1)+t2.*t7.*t10.*(8.0./5.0))-dq2.*t2.*t7.*2.0];