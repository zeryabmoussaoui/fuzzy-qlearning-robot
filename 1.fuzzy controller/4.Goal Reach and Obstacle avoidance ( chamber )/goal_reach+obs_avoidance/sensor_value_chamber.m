function [L_dis, R_dis, F_dis, detect] = sensor_value_chamber(x, y, theta,min_range,max_range,wall_d, wall_u, wall_l,wall_r, obs1, obs2, obs3, obs4)  %sensor_distance(ENV)

[L1_dis, R1_dis, F1_dis, detect_1] = sensor_value(x, y, theta,min_range,max_range, obs1);
[L2_dis, R2_dis, F2_dis, detect_2] = sensor_value(x, y, theta,min_range,max_range, obs2);
[L3_dis, R3_dis, F3_dis, detect_3] = sensor_value(x, y, theta,min_range,max_range, obs3);
[L4_dis, R4_dis, F4_dis, detect_4] = sensor_value(x, y, theta,min_range,max_range, obs4);
%
[Ld_dis, Rd_dis, Fd_dis, detect_5] = sensor_value(x, y, theta,min_range,max_range, wall_d);
[Lu_dis, Ru_dis, Fu_dis, detect_6] = sensor_value(x, y, theta,min_range,max_range, wall_u);
[Ll_dis, Rl_dis, Fl_dis, detect_7] = sensor_value(x, y, theta,min_range,max_range, wall_l);
[Lr_dis, Rr_dis, Fr_dis, detect_8] = sensor_value(x, y, theta,min_range,max_range, wall_r);

L_dis=min([L1_dis L2_dis L3_dis L4_dis Ld_dis Lu_dis Ll_dis Lr_dis ]);
R_dis=min([R1_dis R2_dis R3_dis R4_dis Rd_dis Ru_dis Rl_dis Rr_dis ]);
F_dis=min([F1_dis F2_dis F3_dis F4_dis Fd_dis Fu_dis Fl_dis Fr_dis]);
if ((detect_1==1) | (detect_2==1) | (detect_3==1) | (detect_4==1) | (detect_5==1) | (detect_6==1) | (detect_7==1) | (detect_8==1))
    detect=1;
else
    detect=0;
end
end