function cost = costFun(q,dq,u, h, relaxation,parms)

cost = 0;

if strcmp(parms.costMode,'minNorm')

    for i = 1: parms.totalKnotNumber
        if i == 1 || i == parms.totalKnotNumber
            cost = cost + 1/6*h*u(i)*u(i);
        elseif mod(i,2)==0
            cost = cost + 4/6*h*u(i)*u(i);
        else
            cost = cost + 2/6*h*u(i)*u(i);
        end
    end    
elseif strcmp(parms.costMode,'timeOptimal')    
    
    cost = h*(parms.totalKnotNumber-1)/2;
end



end