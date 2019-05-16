function parms = trajOptConfig(costFunctionType)
%UNTITLED Summary of this function goes here
%
%
% ToDo

%% Main parameters of the system

parms.costMode = costFunctionType;

parms.g = 9.81;
parms.ndof = 2;  % dimension of configuration (joint) space
parms.nb = 0;    % dimension of extended coordinate
parms.numIn = 1; % including toe joint (for toe stiffness)
parms.targetPosition = 0;
parms.initialAngle = pi-pi/6;
parms.targetAngle = pi;

% Note: the following numbers are all 0 
% (parameter for system with potential contact points)

parms.nCstP = 0; % number of contact point 
parms.nCst = 0; % number of contact constraints for each contact point
parms.nCstVar = 0; % number of slack variables for each contact point
parms.nContactConst = parms.nCstP *parms.nCst ;
parms.nBoundaryConst = parms.ndof;
parms.tConstVarNum = parms.nCstP*parms.nCstVar;

%% Main parameters specific to each phase (e.g. variable/constraint bounds)
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
%                  Parameters for the dynamics function                   %
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%
parms = rollerPendulumConfig(parms);

%% Other parameters based on user-defined  specs

totalKnotNumber = 0;
totalHSMCnstNumber = 0;

for i = 1:parms.phaseNum
    totalKnotNumber = totalKnotNumber + parms.phase(i).knotNumber;
    totalHSMCnstNumber = totalHSMCnstNumber + (parms.phase(i).knotNumber-1)/2;
end
    
index = 1;

for i = 1:parms.phaseNum
    parms.phase(i).x0knotNumber = index;
    index = index + parms.phase(i).knotNumber;
end

parms.totalKnotNumber = totalKnotNumber;
parms.totalHSMCnstNumber = totalHSMCnstNumber;
parms.nVarSeg = ( parms.ndof*3+parms.tConstVarNum+parms.numIn ); %number of vars for each time step (segment)
parms.totalVarNumber = parms.totalKnotNumber * parms.nVarSeg + parms.phaseNum + 1 ; % +1: for relaxation

% Cechking input
for i = 1:length(parms.phase)
    if mod(parms.phase(i).knotNumber,2)==0
        error('knotNumber should be an odd number')
    end
end


%% Add Paths

% Path of IPOPT mex file
addpath('E:\ebertolazzi-mexIPOPT\binary\dll')

end
