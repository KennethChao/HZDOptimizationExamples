close all
figure()
plot(q(1,:),dq(1,:))
hold on 
plot(q(2,:),dq(2,:))
hold off


for i = 1: size(q,2)
    [posX,posZ] = FK(q(:,i));
    
    if i == 1
    figure()
    h = plot(posX,posZ,'linewidth',2);
    hold on
    plot([-1 1], [1*tan(parms.psi), -1*tan(parms.psi)])
    else
    set(h,'xdata',posX,'ydata',posZ);

    end
    axis([-1 1, -0.5 1.5])
    pause(0.1)
    
end


function [posX,posZ] = FK(q)
    posZ = [0, cos(q(1)), cos(q(1))-cos(q(2))];
    posX = [0, -sin(q(1)), -sin(q(1))+sin(q(2))];
end