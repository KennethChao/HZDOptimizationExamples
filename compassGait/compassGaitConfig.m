function parms = compassGaitConfig(parms)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
parms.phase(1).knotNumber = 21;
parms.phaseNum = length(parms.phase);

%% Bounds
parms.maxAngle = pi/3*[1 1];
parms.maxAnglularVel = inf;
parms.maxAnglularAccel = inf;
parms.maxTorque = 100;


%%
qlowerBoundFactor = ones(1,parms.ndof);

for i = 1:parms.phaseNum
parms.phase(i).qlb = -parms.maxAngle .* qlowerBoundFactor;
parms.phase(i).dqlb = -parms.maxAnglularVel * ones(1,parms.ndof);
parms.phase(i).ddqlb = -parms.maxAnglularAccel * ones(1,parms.ndof);
parms.phase(i).ulb = -parms.maxTorque;

parms.phase(i).hlb = 1e-5;    

parms.phase(i).qub = parms.maxAngle .* ones(1,parms.ndof);
parms.phase(i).dqub = parms.maxAnglularVel * ones(1,parms.ndof);
parms.phase(i).ddqub = parms.maxAnglularAccel * ones(1,parms.ndof);
parms.phase(i).uub = parms.maxTorque;
                                 
parms.phase(i).hub = 1e-1;

end
                  
parms.relaxationlb = 0;
parms.relaxationub = 1;
                               


end

