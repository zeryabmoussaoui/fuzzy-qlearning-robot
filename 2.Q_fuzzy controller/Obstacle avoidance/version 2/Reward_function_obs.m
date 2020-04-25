function [Reward, Episode_end]= Reward_function_obs(xp,yp,L_sensor_n, R_sensor_n, F_sensor_n,L_sensor_p, R_sensor_p, F_sensor_p, wall_u, wall_d)

 e_L=L_sensor_n-L_sensor_p;
 e_F=F_sensor_n-F_sensor_p;
 e_R=R_sensor_n-R_sensor_p;
 
 if(e_L>0 || e_F>0 || e_R>0)
     Reward=+1;
 else
     Reward=-1;
 end
 Episode_end=1;
 
 %% check if the robot has crushed
 r=0.1;
 pt=0:0.2:2*pi;
 x=xp+r*cos(pt);
 y=yp+r*sin(pt);
 robot=[x;y];
 
 P_u = InterX(robot,wall_u);
 P_d = InterX(robot,wall_d);
 if(length(P_u)==0 && length(P_d)==0 )
    Episode_end=1;
 else
    Reward=-10;
    Episode_end=0;
 end




end