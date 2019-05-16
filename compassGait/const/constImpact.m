function c = constImpact(xVec, parms)
    [n,m]=size(xVec);
    if n<m
       xVec=xVec'; 
    end
        xSeg_minus = xVec( (1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg, 1);
        xSeg_plus = xVec((1:parms.nVarSeg), 1);
        c = ImpactWraper(xSeg_minus,xSeg_plus);
end

