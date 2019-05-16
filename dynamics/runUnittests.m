clc;
clear;
addpath('./unittest')

result = runtests('LagrangeMechanicsTest');
rt1 = table(result)

result = runtests('timeDiffTest');
rt2 = table(result)

result = runtests('comMotionSynthesisTest');
rt3 = table(result)

result = runtests('pointMassMotionSynthesisTest');
rt4 = table(result)


