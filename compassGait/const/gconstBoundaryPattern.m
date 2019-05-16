function g = gconstBoundaryPattern(parms)

%     xSeg_minus = xVec( (1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg, 1);
%     xSeg_plus = xVec((1:parms.nVarSeg), 1);


    
    gMat = zeros(4,parms.totalVarNumber);
    
    gMat(:,(1:parms.nVarSeg)) = [zeros(1,7);
                                 1 1 1 1 0 0 0;
                                 zeros(2,7)];
    gMat(:,(1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg) = [1 1 0 0 0 0 0;
                                                                          zeros(1,7);
                                                                          1 1 1 1 0 0 0;
                                                                          1 1 0 0 0 0 0];
    
    g = sparse(gMat);
end


