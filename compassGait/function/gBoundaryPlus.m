function gBoundaryPlus = gBoundaryPlus(dq1_plus,dq2_plus,psi,q1_plus,q2_plus)
%GBOUNDARYPLUS
%    GBOUNDARYPLUS = GBOUNDARYPLUS(DQ1_PLUS,DQ2_PLUS,PSI,Q1_PLUS,Q2_PLUS)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    27-Mar-2019 15:39:16

t2 = psi+q1_plus;
t3 = psi+q2_plus;
gBoundaryPlus = reshape([0.0,-dq1_plus.*cos(t2),0.0,0.0,0.0,dq2_plus.*cos(t3),0.0,0.0,0.0,-sin(t2),0.0,0.0,0.0,sin(t3),0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0],[4,7]);
