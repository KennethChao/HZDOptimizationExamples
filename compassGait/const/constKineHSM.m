function c = constKineHSM(q,dq,ddq,h,parms)
%CONSTKINEHSM Hermite-Simpson constraints
%   Detailed explanation goes here

dim = parms.ndof*4;

for i = 1: parms.phaseNum
    if parms.phase(i).knotNumber<=2
        error('knotNumber is too small!');
    end
end

c = zeros(parms.totalHSMCnstNumber*dim,1);

iteration = 0;

for i = 1:parms.phaseNum

    indexRange = (1: parms.phase(i).knotNumber) + parms.phase(i).x0knotNumber-1;
    state = [q(:, indexRange);dq(:,indexRange)];
    dState = [dq(:,indexRange);ddq(:,indexRange)];                    

    for j =  1:2: (parms.phase(i).knotNumber-2)
        cSegment1 = state(:,j+2)-state(:,j)-1/6*h(i)*(dState(:,j) + 4*dState(:,j+1)+dState(:,j+2));
        cSegment2 = state(:,j+1)-1/2*(state(:,j) + state(:,j+2))-1/8*h(i)*(dState(:,j)-dState(:,j+2));

        %iterate the segment range for the specific i and j
        cindexRange = dim*(iteration) + (1:dim);% + (parms.phase(i-1).knotNumber-1)*2*dim;            
        c(cindexRange,1) = [cSegment1;cSegment2];
        
        iteration = iteration + 1;
    end

end

