function [Mmat,bvec] = LagrangeMechanics(T,V,x,xd,xdd)
%LAGRANGEMECHANICS Derive the Equation of motion via Largnage Mechacnics
%   Derive the Equation of motion in the form of
%
%   Mmat*ddx = bVec 
%
%   where Mmat is the inertia matrix, and bVec are other non-inertia terms.
%
%   Implemented for the fixed point finder of SLIP-based runners.
%   2018, IHMC

dim = length(x);
eoms = sym('eom',[dim,1]);

L = T-V;

for i = 1:dim
    partialLpartialDx = diff(L,xd(i));
    partialLpartialx = diff(L,x(i));
    
    eoms(i) = simplify(timeDiff(partialLpartialDx,x,xd,xdd) ...
              -partialLpartialx);
end

Mmat = simplify(jacobian(eoms,xdd));
bvec = simplify(Mmat*xdd -eoms);

end

