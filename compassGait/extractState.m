function [q, dq, ddq, u, h, relaxation, varargout] = extractState(xVec, parms)

if size(xVec,1)<size(xVec,1)
    error('aVec should be a column vector!');
end
q = zeros(parms.ndof, parms.totalKnotNumber);
dq = zeros(parms.ndof, parms.totalKnotNumber);
ddq = zeros(parms.ndof, parms.totalKnotNumber);
u = zeros(parms.numIn, parms.totalKnotNumber);
h = zeros(1,parms.phaseNum);

for i = 1:parms.totalKnotNumber
    q(:, i) = xVec((i - 1)*parms.nVarSeg+(1:parms.ndof), 1);
    dq(:, i) = xVec((i - 1)*parms.nVarSeg+(1:parms.ndof)+parms.ndof, 1);
    ddq(:, i) = xVec((i - 1)*parms.nVarSeg+(1:parms.ndof)+parms.ndof*2, 1);
    u(:, i) = xVec((i - 1)*parms.nVarSeg+(1:parms.numIn)+parms.ndof*3, 1);       
end

for i = 1:length(parms.phase)
     h(i) = xVec(end-i);
end

    relaxation = xVec(end);


    
    
end
