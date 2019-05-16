function parms = rollerPendulumConfig(parms)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
parms.phase(1).knotNumber = 201;
parms.phaseNum = length(parms.phase);

%% Bounds
parms.maxAngle = 2*pi;
parms.maxAnglularVel = inf;
parms.maxAnglularAccel = inf;
if strcmp(parms.costMode,'minNorm')
parms.maxTorque = 1000;
elseif strcmp(parms.costMode,'timeOptimal')
parms.maxTorque = 1;    
end

%%
qlowerBoundFactor = ones(1,parms.ndof);

for i = 1:parms.phaseNum
parms.phase(i).qlb = -parms.maxAngle .* qlowerBoundFactor;
parms.phase(i).dqlb = -parms.maxAnglularVel * ones(1,parms.ndof);
parms.phase(i).ddqlb = -parms.maxAnglularAccel * ones(1,parms.ndof);
parms.phase(i).ulb = -parms.maxTorque;

if strcmp(parms.costMode,'minNorm')
parms.phase(i).hlb = 1/(parms.phase(1).knotNumber-1)*2;
elseif strcmp(parms.costMode,'timeOptimal')
parms.phase(i).hlb = 1e-5;    
end

parms.phase(i).qub = parms.maxAngle .* ones(1,parms.ndof);
parms.phase(i).dqub = parms.maxAnglularVel * ones(1,parms.ndof);
parms.phase(i).ddqub = parms.maxAnglularAccel * ones(1,parms.ndof);
parms.phase(i).uub = parms.maxTorque;
                                 
if strcmp(parms.costMode,'minNorm')
parms.phase(i).hub = 1/(parms.phase(1).knotNumber-1)*2;
elseif strcmp(parms.costMode,'timeOptimal')
parms.phase(i).hub = 10;
end

end
                  
parms.relaxationlb = 0;
parms.relaxationub = 1;
                               


end

