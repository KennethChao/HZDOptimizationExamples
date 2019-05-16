function g = gconstKineHSM(q, dq, ddq, h, parms) %x, dx, ddx, h,
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    ndof = parms.ndof;
    otherDim = parms.nVarSeg - parms.ndof*3;

    iter = 0;
    oldInd = 0;
    shiftIndex = 0;
    
    for i=1:parms.phaseNum
        if i==1
              nRow = parms.ndof*4;
              nCol = parms.totalVarNumber;              
              gI=nan( (nRow)*(parms.totalHSMCnstNumber),1);
              gJ=nan( (nRow)*(parms.totalHSMCnstNumber),1);
              gV=nan( (nRow)*(parms.totalHSMCnstNumber),1);    
        end
        
        indexRange = (1: parms.phase(i).knotNumber) + parms.phase(i).x0knotNumber-1;
        dqSeg = dq(:,indexRange);
        ddqSeg = ddq(:,indexRange);         
        
        for j=1:2:(parms.phase(i).knotNumber-2)
            
          
                                                 
        gSeg1 = [-1*eye(ndof), -1/6*h(i)*eye(ndof), zeros(ndof),  zeros(ndof,otherDim),...
                  zeros(ndof), -4/6*h(i)*eye(ndof), zeros(ndof),  zeros(ndof,otherDim),...
                    eye(ndof), -1/6*h(i)*eye(ndof), zeros(ndof),  zeros(ndof,otherDim)];
               
        gSeg2 = [zeros(ndof),  -1*eye(ndof), -1/6*h(i)*eye(ndof),  zeros(ndof,otherDim),... 
                 zeros(ndof),   zeros(ndof), -4/6*h(i)*eye(ndof),  zeros(ndof,otherDim)... 
                 zeros(ndof),     eye(ndof), -1/6*h(i)*eye(ndof),  zeros(ndof,otherDim)];               

        gSeg3 = [-1/2*eye(ndof), -1/8*h(i)*eye(ndof), zeros(ndof),  zeros(ndof,otherDim)...
                      eye(ndof),         zeros(ndof), zeros(ndof),  zeros(ndof,otherDim)...
                 -1/2*eye(ndof),  1/8*h(i)*eye(ndof), zeros(ndof),  zeros(ndof,otherDim)];
               
        gSeg4 = [zeros(ndof),  -1/2*eye(ndof), -1/8*h(i)*eye(ndof),  zeros(ndof,otherDim)... 
                 zeros(ndof),       eye(ndof),         zeros(ndof),  zeros(ndof,otherDim)... 
                 zeros(ndof),  -1/2*eye(ndof),  1/8*h(i)*eye(ndof),  zeros(ndof,otherDim)];   
             
        gSeg1h = -1/6*dqSeg(:,j)-4/6*dqSeg(:,j+1)-1/6*dqSeg(:,j+2);
             
        gSeg2h = -1/6*ddqSeg(:,j)-4/6*ddqSeg(:,j+1)-1/6*ddqSeg(:,j+2);
             
        gSeg3h = -1/8*dqSeg(:,j)+1/8*dqSeg(:,j+2);             
             
        gSeg4h = -1/8*ddqSeg(:,j)+1/8*ddqSeg(:,j+2);                          

        
        gSegKine = [gSeg1;
                    gSeg2;
                    gSeg3;
                    gSeg4];

        gKineh =  [gSeg1h;
                   gSeg2h;
                   gSeg3h;
                   gSeg4h];

        sparseK = sparse(gSegKine);
        [SegI_K,SegJ_K,SegV_K] = find(sparseK);
              
        sparseKh = sparse(gKineh);
        [SegI_Kh,~,SegV_Kh] = find(sparseKh);        
        
        shiftInd = size(SegI_K,1)+size(SegI_Kh,1);

        gI((1:shiftInd)+oldInd,1) = [SegI_K+(nRow)*(iter);...
                                     SegI_Kh+(nRow)*(iter)];

                                                       % Seems right but hard to understand! 
        gJ((1:shiftInd)+oldInd,1) = [SegJ_K+(parms.nVarSeg)*((iter )*2 + (i-1));...
                                     (parms.totalVarNumber-i)*ones((size(SegI_Kh,1)),1)];

        gV((1:shiftInd)+oldInd,1) = [SegV_K;...
                                     SegV_Kh];
        oldInd = oldInd+shiftInd;
        iter = iter+1;
        
        end
        
        shiftIndex = shiftIndex + parms.phase(i).knotNumber;
    end
    
    g = sparse(gI(1:oldInd,1),gJ(1:oldInd,1),gV(1:oldInd,1),nRow*parms.totalHSMCnstNumber,parms.totalVarNumber);

end

