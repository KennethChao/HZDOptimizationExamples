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
elseif strcmp(type,'All')     
    clb = [clbKine, clbDym];
    cub = [cubKine, cubDym];         
end

end %function end