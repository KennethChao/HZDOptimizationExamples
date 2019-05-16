function g = gconstDymPattern(parms)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    oldInd = 0;
    
    for i=1:parms.totalKnotNumber
        if i==1
            nRow = parms.ndof;
            nCol = parms.totalVarNumber;
            gI=nan( (nRow)*nCol,1);
            gJ=nan( (nRow)*nCol,1);
            gV=nan( (nRow)*nCol,1);    
        end

        gSegDym = [0 1 1 1 1 1 1 ;
                   0 1 0 0 1 1 0];
        sparseD = sparse(gSegDym);
        [SegI_D,SegJ_D,SegV_D] = find(sparseD);

        shiftInd = length(SegI_D);

        gI((1:shiftInd)+oldInd,1) = SegI_D+(nRow)*(i-1);

        gJ((1:shiftInd)+oldInd,1) = SegJ_D+(parms.nVarSeg)*(i-1 );

        gV((1:shiftInd)+oldInd,1) = SegV_D;

        oldInd = oldInd+shiftInd;
    end
    
    g = sparse(gI(1:oldInd,1),gJ(1:oldInd,1),gV(1:oldInd,1),nRow*(parms.totalKnotNumber),parms.totalVarNumber);

end


