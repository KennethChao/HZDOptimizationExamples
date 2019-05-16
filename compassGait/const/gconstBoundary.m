function g = gconstBoundary(xVec,parms)
   [n,m]=size(xVec);
    if n<m
        xVec=xVec'; 
    end

%     xSeg_minus = xVec( (1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg, 1);
%     xSeg_plus = xVec((1:parms.nVarSeg), 1);
        psi = parms.psi;

        xSeg_minus = xVec( (1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg, 1);
        xSeg_plus = xVec((1:parms.nVarSeg), 1);
        
        q1_plus = xSeg_plus(1); 
        q2_plus = xSeg_plus(2);
        dq1_plus = xSeg_plus(3); 
        dq2_plus = xSeg_plus(4);
        
        q1_minus = xSeg_minus(1); 
        q2_minus = xSeg_minus(2);
        dq1_minus = xSeg_minus(3); 
        dq2_minus = xSeg_minus(4);     

    
    gMat = zeros(4,parms.totalVarNumber);
    
  
    
    gMat(:,(1:parms.nVarSeg)) = gBoundaryPlus(dq1_plus,dq2_plus,psi,q1_plus,q2_plus);
    gMat(:,(1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg) = gBoundaryMinus(dq1_minus,dq2_minus,psi,q1_minus,q2_minus);
    
    g = sparse(gMat);
end


