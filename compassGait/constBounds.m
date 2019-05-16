function [clb, cub] = constBounds(parms,type)

%%
% Bounds of Kinematic Constraints
nHSM = 2;
relativeDegree = 2;
clbKine = zeros(1,parms.totalHSMCnstNumber*parms.ndof*nHSM*relativeDegree);
cubKine = zeros(1,parms.totalHSMCnstNumber*parms.ndof*nHSM*relativeDegree);

% Bounds of Dynamic Constraints
clbDym = zeros(1,(parms.totalKnotNumber)*parms.ndof);
cubDym = zeros(1,(parms.totalKnotNumber)*parms.ndof);

% Bounds of Impact Constraints
clbImpact = [0, 0];
cubImpact = [0, 0];

% Bounds of Periodic Constraints
clbPeriodic = [0, 0];
cubPeriodic = [0, 0];

% Bounds of Boundary Constraints
clbBoundary = [0, 0, -inf, parms.stepLength];
cubBoundary = [0, inf,  0, 1.0];

%%

if strcmp(type,'KineHSM')
    clb = clbKine;
    cub = cubKine;
elseif strcmp(type,'Dym')
    clb = clbDym;
    cub = cubDym;
elseif strcmp(type,'Cost')
    clb = [];
    cub = [];
elseif strcmp(type,'Impact')
    clb = clbImpact;
    cub = cubImpact;
elseif strcmp(type,'Periodic')
    clb = clbPeriodic;
    cub = cubPeriodic;    
elseif strcmp(type,'Boundary')
    clb = clbBoundary;
    cub = cubBoundary;   
elseif strcmp(type,'All')     
    clb = [clbKine, clbDym, clbImpact, clbPeriodic, clbBoundary];
    cub = [cubKine, cubDym, cubImpact, cubPeriodic, cubBoundary];         
end

end %function end