function c = constDym(xVec, parms)
    [n,m]=size(xVec);
    if n<m
       xVec=xVec'; 
    end

    c = zeros(parms.ndof*parms.totalKnotNumber, 1);
    
    for i=1:parms.totalKnotNumber
        xSeg = xVec( (1:parms.nVarSeg)+ (i-1)*parms.nVarSeg, 1);
        dymSeg =  Dine(xSeg); %h is required
        c((parms.ndof)*(i-1)+(1:parms.ndof),:) =  dymSeg;    
    end
end

