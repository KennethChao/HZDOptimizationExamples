syms q1_minus q2_minus dq1_minus dq2_minus ddq1_minus ddq2_minus u_minus real

syms q1_plus q2_plus dq1_plus dq2_plus ddq1_plus ddq2_plus u_plus psi real

g = 9.81;
mHip = 10;
m = 5;
a = 0.5;
b = 0.5;
l = a + b;

%% Boundary Conditioin
c = [%cos(q1_plus + psi) - cos(q2_plus + psi) ; % Normal distance_Start
     cos(q1_minus + psi) - cos(q2_minus + psi) ; % Nomral distance_End
     -sin(q1_plus + psi)*dq1_plus + sin(q2_plus + psi)*dq2_plus ; % Normal velocity_Start
     -sin(q1_minus + psi)*dq1_minus + sin(q2_minus + psi)*dq2_minus ; % Normal velocity_End             
     -sin(q1_minus) + sin(q2_minus) ; % Step length
    ];
matlabFunction(c,'File','Boundary');


%%Gradient of Boundary Conditioin
for i = 1:length(c)
gBoundaryMinus(i,:) = gradient(c(i), [q1_minus q2_minus dq1_minus dq2_minus ddq1_minus ddq2_minus u_minus])';
end
% gImpactMinusOutput2 = gradient(impactOutput2, [q1 q2 dq1 dq2 ddq1 ddq2 u])';
% gImpactOutputMinus = [gImpactMinusOutput1;gImpactMinusOutput2];
gBoundaryMinusPattern = gBoundaryMinus;
gBoundaryMinusPattern(gBoundaryMinusPattern~=0)=1
matlabFunction(gBoundaryMinus,'File','gBoundaryMinus');

for i = 1:length(c)
gBoundaryPlus(i,:) = gradient(c(i), [q1_plus q2_plus dq1_plus dq2_plus ddq1_plus ddq2_plus u_plus])';
end
% gImpactMinusOutput2 = gradient(impactOutput2, [q1 q2 dq1 dq2 ddq1 ddq2 u])';
% gImpactOutputMinus = [gImpactMinusOutput1;gImpactMinusOutput2];
gBoundaryPlusPattern = gBoundaryPlus;
gBoundaryPlusPattern(gBoundaryPlusPattern~=0)=1
matlabFunction(gBoundaryPlus,'File','gBoundaryPlus');



    




