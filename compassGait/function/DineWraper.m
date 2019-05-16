function output = DineWraper(xVec)

q1 = xVec(1);
q2 = xVec(2);
dq1 = xVec(3);
dq2 = xVec(4);
ddq1 = xVec(5);
ddq2 = xVec(6);
u = xVec(7);

output = Dine(ddq1,ddq2,dq1,dq2,q1,q2,u);