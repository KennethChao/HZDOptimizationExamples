function output = gImpactPlusWraper(xVec_plus)

% q1 = xVec_minus(1);
% q2 = xVec_minus(2);
% dq1 = xVec_minus(3);
% dq2 = xVec_minus(4);
% ddq1 = xVec_minus(5);
% ddq2 = xVec_minus(6);
% u = xVec_minus(7);

dq1_plus = xVec_plus(3);
dq2_plus = xVec_plus(4);

output = gImpactPlus();