function [L_dis, R_dis, F_dis, detect] = sensor_value(x, y, theta,min_range,max_range, ENV)  %sensor_distance(ENV)
% the coorinates of the range of detection of the three sensors
[L_sensor R_sensor F_sensor]= sensors_pos(x,y,theta,min_range,max_range);

% intersection ENV with L_sensor
P_L = InterX(ENV,L_sensor);
if(length(P_L)==0)
    L_dis= max_range;
else
    if(size(P_L)==[2 1])
        L_dis=sqrt((P_L(1)-x)^2+(P_L(2)-y)^2);
    % in case there is 2 or more intersections
    else
        pt_1=sqrt((P_L(1,1)-x)^2+(P_L(2,1)-y)^2)
        pt_2=sqrt((P_L(2,1)-x)^2+(P_L(2,2)-y)^2)
        L_dis= min([pt_1 pt_2]);
    end
end

P_R = InterX(ENV,R_sensor);
if(length(P_R)==0)
    R_dis= max_range;
else
    if(size(P_R)==[2 1])
        R_dis=sqrt((P_R(1)-x)^2+(P_R(2)-y)^2);
    % in case there is 2 or more intersections ( assigne a value )
    else
        pt_1=sqrt((P_R(1,1)-x)^2+(P_R(2,1)-y)^2);
        pt_2=sqrt((P_R(2,1)-x)^2+(P_R(2,2)-y)^2);
        R_dis= min([pt_1 pt_2]);
    end
end

P_F = InterX(ENV,F_sensor);
if(length(P_F)==0)
    F_dis= max_range;
else
    if(size(P_F)==[2 1])
        F_dis=sqrt((P_F(1)-x)^2+(P_F(2)-y)^2);
    % in case there is 2 or more intersections
    else
        pt_1=sqrt((P_F(1,1)-x)^2+(P_F(2,1)-y)^2);
        pt_2=sqrt((P_F(2,1)-x)^2+(P_F(2,2)-y)^2);
        F_dis= min([pt_1 pt_2]);
    end
end

if ( (F_dis==max_range) & (L_dis==max_range) & (R_dis==max_range))
    detect=0;
else
    detect=1;
end

end