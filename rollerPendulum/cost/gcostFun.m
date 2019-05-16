function gcost = gcostFun(q,dq,u, h, relaxation,parms)
%

gcost = zeros(1,parms.totalVarNumber);
jumpIndex = parms.ndof*3 + 1;
if strcmp(parms.costMode,'minNorm')

    for i = 1: parms.totalKnotNumber
        if i==1 || i==parms.totalKnotNumber
        gcost(jumpIndex + jumpIndex*(i-1)) = 1/6*h*2*u(i);
        elseif mod(i,2)==0
        gcost(jumpIndex + jumpIndex*(i-1)) = 4/6*h*2*u(i);
        else
        gcost(jumpIndex + jumpIndex*(i-1)) = 2/6*h*2*u(i);            
        end
    end
    cost = costFun(q,dq,u, h, relaxation,parms);    
    gcost(end-1) = cost/h;
elseif strcmp(parms.costMode,'timeOptimal')    
    
    gcost(end-1) = (parms.totalKnotNumber-1)/2;

end

