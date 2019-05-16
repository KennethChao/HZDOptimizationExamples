function g = gconstImpact(xVec,parms)
   [n,m]=size(xVec);
    if n<m
        xVec=xVec'; 
    end

    xSeg_minus = xVec( (1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg, 1);
    xSeg_plus = xVec((1:parms.nVarSeg), 1);
    
    gMat = zeros(2,parms.totalVarNumber);
    
    gImpactPlus = gImpactPlusWraper(xSeg_plus);
    gImpactMinus = gImpactMinusWraper(xSeg_minus);
    
    gMat(:,(1:parms.nVarSeg)) = gImpactPlus;
    gMat(:,(1:parms.nVarSeg)+ (parms.totalKnotNumber-1)*parms.nVarSeg) = gImpactMinus;
    
%     oldInd = 0;

%     for i=1:parms.totalKnotNumber
%         xSeg = xVec( (1:parms.nVarSeg)+ (i-1)*parms.nVarSeg, 1);    
%         gSegDine = gDineWraper(xSeg);
% 
%         if i==1
%               nRow = parms.ndof;
%               nCol = parms.nVarSeg;
%               gI=nan( (nRow)*(nCol)*(parms.totalKnotNumber),1);
%               gJ=nan( (nRow)*(nCol)*(parms.totalKnotNumber),1);
%               gV=nan( (nRow)*(nCol)*(parms.totalKnotNumber),1);    
%         end
%         sparseD = sparse(gSegDine);
%         [SegI,SegJ,SegV] = find(sparseD);
% 
%         shiftInd = length(SegI);
% 
%         gI((1:shiftInd)+oldInd,1) = SegI+(nRow)*(i-1);
%         gJ((1:shiftInd)+oldInd,1) = SegJ+(parms.nVarSeg)*(i-1);
%         gV((1:shiftInd)+oldInd,1) = SegV;
% 
%         oldInd = oldInd+shiftInd;
%     end
    g = sparse(gMat);
end


