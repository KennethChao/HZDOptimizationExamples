function c = Boundary(dq1_plus,dq2_plus,dq1_minus,dq2_minus,psi,q1_plus,q2_plus,q1_minus,q2_minus)
%BOUNDARY
%    C = BOUNDARY(DQ1_PLUS,DQ2_PLUS,DQ1_MINUS,DQ2_MINUS,PSI,Q1_PLUS,Q2_PLUS,Q1_MINUS,Q2_MINUS)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    27-Mar-2019 15:39:16

t2 = psi+q1_minus;
t3 = psi+q2_minus;
c = [cos(t2)-cos(t3);-dq1_plus.*sin(psi+q1_plus)+dq2_plus.*sin(psi+q2_plus);-dq1_minus.*sin(t2)+dq2_minus.*sin(t3);-sin(q1_minus)+sin(q2_minus)];
