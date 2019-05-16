function [lb, ub] =  inputBounds(parms)

lb = -inf*ones(1,parms.totalVarNumber);
ub = inf*ones(1,parms.totalVarNumber);
iteration = 0;

for i = 1:parms.phaseNum
    for j = 1:parms.phase(i).knotNumber
        
        if j == 1
            lbSeg = [...
                        0,...
                        0,...  
                        -inf,...
                        parms.phase(i).ulb,... 
                       ];    

            ubSeg = [...
                        0,...
                        0,...  
                        inf,...
                        parms.phase(i).uub,... 
                      ];            

        elseif    j == parms.phase(i).knotNumber 
            lbSeg = [...
                        1,...
                        0,...  
                        -inf,...
                        parms.phase(i).ulb,... 
                       ];    

            ubSeg = [...
                        1,...
                        0,...  
                        inf,...
                        parms.phase(i).uub,... 
                      ];                        
        else
            lbSeg = [...
                        parms.phase(i).qlb,...
                        parms.phase(i).dqlb,...  
                        parms.phase(i).ddqlb,...
                        parms.phase(i).ulb,... 
                       ];    

            ubSeg = [...
                        parms.phase(i).qub,...
                        parms.phase(i).dqub,...  
                        parms.phase(i).ddqub,...
                        parms.phase(i).uub,... 
                      ];
        end

    lb((1:parms.nVarSeg) + iteration*parms.nVarSeg ) = lbSeg;
    ub((1:parms.nVarSeg) + iteration*parms.nVarSeg ) = ubSeg;
    iteration = iteration + 1;
    end
    lb(end-i) = parms.phase(i).hlb;
    ub(end-i) = parms.phase(i).hub;
end

end

