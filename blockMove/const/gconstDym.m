function g = gconstDym(xVec,parms)
   [n,m]=size(xVec);
    if n<m
        xVec=xVec'; 
    end

    oldInd = 0;

    for i=1:parms.totalKnotNumber
        xSeg = xVec( (1:parms.nVarSeg)+ (i-1)*parms.nVarSeg, 1);    
        gSegDine = [0 0 1 -1];

        if i==1
              nRow = parms.ndof;
              nCol = parms.nVarSeg;
              gI=nan( (nRow)*(nCol)*(parms.totalKnotNumber),1);
              gJ=nan( (nRow)*(nCol)*(parms.totalKnotNumber),1);
              gV=nan( (nRow)*(nCol)*(parms.totalKnotNumber),1);    
        end
        sparseD = sparse(gSegDine);
        [SegI,SegJ,SegV] = find(sparseD);

        shiftInd = length(SegI);

        gI((1:shiftInd)+oldInd,1) = SegI+(nRow)*(i-1);
        gJ((1:shiftInd)+oldInd,1) = SegJ+(parms.nVarSeg)*(i-1);
        gV((1:shiftInd)+oldInd,1) = SegV;

        oldInd = oldInd+shiftInd;
    end
    g = sparse(gI(1:oldInd,1),gJ(1:oldInd,1),gV(1:oldInd,1),nRow*(parms.totalKnotNumber),parms.totalVarNumber);
end


