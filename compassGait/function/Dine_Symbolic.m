syms q1 q2 dq1 dq2 ddq1 ddq2 u real

syms q1_plus q2_plus dq1_plus dq2_plus ddq1_plus ddq2_plus u_plus real

g = 9.81;
mHip = 10;
m = 5;
a = 0.5;
b = 0.5;
l = a + b;

p1 = (mHip + m)*l^2 + m*a^2;
p2 = m*l*b;
p3 = m*b^2;
p4 = (mHip*l + m*b + m*l)*g;
p5 = m*b*g;

%% EOM
output1 = p1*ddq1 - p2*cos(q1-q2)*ddq2 - p2*sin(q1-q2)*dq2^2 - p4*sin(q1) - u;
output2 = p3*ddq2 - p2*cos(q1-q2)*ddq1 + p2*sin(q1-q2)*dq1^2 + p5*sin(q2) + u;

% Export Dine
output = [output1; output2];
matlabFunction(output,'File','Dine');

%% Gradient of EOM
gOutput1 = gradient(output1, [q1 q2 dq1 dq2 ddq1 ddq2 u])';
gOutput2 = gradient(output2, [q1 q2 dq1 dq2 ddq1 ddq2 u])';

% Export gDine
gOutput = [gOutput1;gOutput2];
matlabFunction(gOutput,'File','gDine');

%% Impact Map 
p6 = m*a*b;
p7 = mHip*l^2 + 2*m*a*l;
c12 = cos(q1-q2);

Amat = [p1 - p2*c12, p3 - p2*c12;
        -p2*c12    , p3         ];
    
Bmat = [p7*c12 - p6, -p6;
        -p6        , 0  ];
dq = [dq1;dq2];    
dqPlus = Amat^-1*Bmat*dq;
impactOutput1 = dq1_plus - dqPlus(1);
impactOutput2 = dq2_plus - dqPlus(2);
impactOutput = [impactOutput1; impactOutput2];
matlabFunction(impactOutput,'File','Impact');

%% Gradient of Impact map
gImpactMinusOutput1 = gradient(impactOutput1, [q1 q2 dq1 dq2 ddq1 ddq2 u])';
gImpactMinusOutput2 = gradient(impactOutput2, [q1 q2 dq1 dq2 ddq1 ddq2 u])';
gImpactOutputMinus = [gImpactMinusOutput1;gImpactMinusOutput2];
gImpactOutputMinusPattern = gImpactOutputMinus;
gImpactOutputMinusPattern(gImpactOutputMinusPattern~=0)=1
matlabFunction(gImpactOutputMinus,'File','gImpactMinus');

gImpactPlusOutput1 = gradient(impactOutput1, [q1_plus q2_plus dq1_plus dq2_plus ddq1_plus ddq2_plus u_plus])';
gImpactPlusOutput2 = gradient(impactOutput2, [q1_plus q2_plus dq1_plus dq2_plus ddq1_plus ddq2_plus u_plus])';
gImpactOutputPlus = [gImpactPlusOutput1;gImpactPlusOutput2];
gImpactOutputPlusPattern = gImpactOutputPlus;
gImpactOutputPlusPattern(gImpactOutputPlusPattern~=0)=1
matlabFunction(gImpactOutputPlus,'File','gImpactPlus');

   
%% EOM (passive)

output1 = p1*ddq1 - p2*cos(q1-q2)*ddq2 - p2*sin(q1-q2)*dq2^2 - p4*sin(q1);
output2 = p3*ddq2 - p2*cos(q1-q2)*ddq1 + p2*sin(q1-q2)*dq1^2 + p5*sin(q2);

output = [output1; output2];

Mmat1 = gradient(output1, [ddq1 ddq2])';
Mmat2 = gradient(output2, [ddq1 ddq2])';
Mmat = [Mmat1;Mmat2];

CGVec = output - Mmat*[ddq1;ddq2];

Mmat*[ddq1;ddq2] +CGVec - output




delta = Amat^-1*Bmat;
matlabFunction(delta,'File','delta');


%% EOM 

% output1 = p1*ddq1 - p2*cos(q1-q2)*ddq2 - p2*sin(q1-q2)*dq2^2 - p4*sin(q1);
% output2 = p3*ddq2 - p2*cos(q1-q2)*ddq1 + p2*sin(q1-q2)*dq1^2 + p5*sin(q2);
% 
% output = [output1; output2];
% 
% Mmat1 = gradient(output1, [ddq1 ddq2])';
% Mmat2 = gradient(output2, [ddq1 ddq2])';
% Mmat = [Mmat1;Mmat2];
% 
% CGVec = output - Mmat*[ddq1;ddq2];
% 
% Mmat*[ddq1;ddq2] +CGVec - output

fx = Mmat^-1*(-CGVec + [u;-u]);
matlabFunction(fx,'File','dym_active');

fx = Mmat^-1*(-CGVec);
matlabFunction(fx,'File','fx_active');

gx = Mmat^-1*[1;-1];
matlabFunction(gx,'File','gx_active');