function output = Dine(xVec)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
x = xVec(1);
dx = xVec(2);
ddx = xVec(3);
F = xVec(4);
m = 1;
output = m*ddx-F;

end

