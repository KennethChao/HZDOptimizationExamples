function gcost = gcostFun(q,dq,u, h, relaxation,parms)
%

gcost = zeros(1,parms.totalVarNumber);
inputIndex = parms.ndof*3 +1;
    
for i = 1: parms.totalKnotNumber


    if i==1 || i==parms.totalKnotNumber
    gcost(inputIndex + inputIndex*(i-1)) = 1/6*h*2*u(i);
    elseif mod(i,2)==0
    gcost(inputIndex + inputIndex*(i-1)) = 4/6*h*2*u(i);
    else
    gcost(inputIndex + inputIndex*(i-1)) = 2/6*h*2*u(i);            
    end
end



if strcmp(parms.costMode, 'withSensitivityFunction')
%     cost = parms.weighting*(sin(q(2,end)+parms.psi) - sin(q(1,end)+parms.psi) );
jumpedIndex = inputIndex*(parms.totalKnotNumber -1);
gcost(jumpedIndex+1) = -parms.weighting*cos(q(1,end)+parms.psi);
gcost(jumpedIndex+2) = parms.weighting*cos(q(2,end)+parms.psi);


end

parms.costMode = 'cost';
cost = costFun(q,dq,u, h, relaxation,parms);    
gcost(end-1) = cost/h;



