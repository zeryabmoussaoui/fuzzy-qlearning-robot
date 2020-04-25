close all
clear all;
clc;

% robot parameters 
R = 0.035; L = 0.28; shape_r=0.1;
min_range=0.1; max_range=0.4;

% simulation parameters 
sim_delta = 0.1;   
t=0;
t_final=200;
 
% var for initialization
x_init=0; y_init=3.6; theta_init=45*pi/180;
xp_pos=x_init ;yp_pos=y_init; thetap=theta_init; 
 
% vectors for visualization 
vect_t=[];
vect_x=[];
vect_y=[];
vect_theta=[];

vect_L_dis=[];
vect_R_dis=[];
vect_F_dis=[];


% vector of the enivronment points
[ wall_u wall_d] = environment_type2();

 while(1)
     
     % returns the distances measured and detect(0 and 1 if there is obs )
     [L_dis, R_dis, F_dis, detect] = sensor_value_obs(xp_pos, yp_pos, thetap,min_range,max_range, wall_u, wall_d)
     
     % vectors used for the animation
     vect_L_dis=[vect_L_dis L_dis];
     vect_R_dis=[vect_R_dis R_dis];
     vect_F_dis=[vect_F_dis F_dis];
     
     if (detect == 0)
         w_lc=0.6; w_rc=0.6;
     else
         [w_lc, w_rc]= obstacle_avoidance_FLC_corr(L_dis, R_dis, F_dis);
     end
     
     % robot cmd input
     [ w_l,w_r] = Diff_Robot_Model(w_lc, w_rc, sim_delta);
     
     % odometry
     [xn_pos,yn_pos,thetan]= Odometry(w_l, w_r, sim_delta,xp_pos,yp_pos, thetap,[R L]);
     xp_pos=xn_pos ;yp_pos=yn_pos; thetap=thetan;
 
     % filling the plot vectors 
     vect_t=[vect_t t];
     vect_x=[vect_x xp_pos];
     vect_y=[vect_y yp_pos];
     vect_theta=[vect_theta thetap];
       
 t=t+sim_delta;
 if(t>t_final)
     break
 end
 end
 
 figure(1)
 plot(vect_x,vect_y); title('robot position'); xlabel('x(m)'); ylabel('y(m)');
 figure(2)
 draw_PFE2(vect_x, vect_y,vect_theta,vect_t,x_init,y_init);
 %pause()
 %visualization_vect(vect_x, vect_y,vect_theta, vect_t,min_range,max_range,wall_u, wall_d);