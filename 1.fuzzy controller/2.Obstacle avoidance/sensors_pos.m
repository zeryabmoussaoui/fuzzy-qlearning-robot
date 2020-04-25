function [L_sensor R_sensor F_sensor]= sensors_pos(x,y,theta,min_range,max_range)
pt=min_range:0.03:max_range;

% I made a mistake her concernig the direction 
R_sensor= [ x+pt*cos(-pi/3+theta); y+pt*sin(-pi/3+theta)];
L_sensor= [x+pt*cos(theta+pi/3); y+pt*sin(theta+pi/3)];
F_sensor= [x+pt*cos(theta);y+pt*sin(theta)];

%plot(R_sensor(1,:),R_sensor(2,:),'r',L_sensor(1,:),L_sensor(2,:),'b',F_sensor(1,:),F_sensor(2,:),'g');
%hold on
end