function gx = gx_active(q1,q2)
%GX_ACTIVE
%    GX = GX_ACTIVE(Q1,Q2)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    24-Apr-2019 00:10:47

t3 = q1-q2;
t2 = cos(t3);
t4 = t2.^2;
t5 = t4.*4.0;
t6 = t5-1.3e1;
t7 = 1.0./t6;
t8 = t2.*t7.*(8.0./5.0);
gx = [t7.*(-4.0./5.0)+t8;t7.*(5.2e1./5.0)-t8];