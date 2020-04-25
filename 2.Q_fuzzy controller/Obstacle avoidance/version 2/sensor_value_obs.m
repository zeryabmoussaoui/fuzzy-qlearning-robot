function [L_dis, R_dis, F_dis, detect] = sensor_value_obs(x, y, theta,min_range,max_range, obs1, obs2)  %sensor_distance(ENV)


[L1_dis, R1_dis, F1_dis, detect_1] = sensor_value(x, y, theta,min_range,max_range, obs1);
[L2_dis, R2_dis, F2_dis, detect_2] = sensor_value(x, y, theta,min_range,max_range, obs2);

L_dis=min([L1_dis L2_dis]);
R_dis=min([R1_dis R2_dis]);
F_dis=min([F1_dis F2_dis]);
if ((detect_1==1) | (detect_2==1))
    detect=1;
else
    detect=0;
end
end