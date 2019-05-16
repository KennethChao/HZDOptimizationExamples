function g = gconstPeriodicPattern(parms)
   
%     xSeg_minus = xVec( (1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg, 1);
%     xSeg_plus = xVec((1:parms.nVarSeg), 1);
    
    gMat = zeros(2,parms.totalVarNumber);
    
    gImpactPlus = [1 0 0 0 0 0 0;
                   0 1 0 0 0 0 0];
    gImpactMinus = [0 -1 0 0 0 0 0;
                    -1 0 0 0 0 0 0]; 
    
    gMat(:,(1:parms.nVarSeg)) = gImpactPlus;
    gMat(:,(1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg) = gImpactMinus;
    
    g = sparse(gMat);
end


