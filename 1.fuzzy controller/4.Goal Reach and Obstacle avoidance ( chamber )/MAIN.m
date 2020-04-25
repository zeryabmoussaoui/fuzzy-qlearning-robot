close all;
clear all;
clc;

% robot parameters 
R = 0.04; L = 0.15;
min_range=0.1; max_range=0.4;

% simulation parameters 
sim_delta = 0.1;   
t=0;
t_final=200;
 
% var for initialization
x_init=0.5; y_init=0.5; theta_init=0*pi/180;

xp_pos=x_init ;yp_pos=y_init; thetap=theta_init; % inilial position and orientation
 
% vectors for plotting
vect_x=[];
vect_y=[]; 
vect_theta=[];
vect_t=[];

% vector of the enivronment points
[wall_d wall_u wall_l wall_r obs1 obs2 obs3 obs4 ]= obstacles_chamber();

% desired position
x_d=4; y_d=4;


while(1)
     
     % returns the distances measured and detect(0 and 1 if there is obs )
     [L_dis, R_dis, F_dis, detect] = sensor_value_chamber(xp_pos, yp_pos, thetap,min_range,max_range, wall_d, wall_u, wall_l,wall_r, obs1, obs2, obs3, obs4);
     
     if (detect == 0)
         % error calclation
         [d_error, theta_error]= Error(xp_pos, yp_pos, thetap, x_d, y_d);
         
         % fuzzy controller
         [w_lc,w_rc ]= fuzzy_controller_w(d_error,theta_error);
     else
         [w_lc, w_rc]= obstacle_avoidance_FLC_corr(L_dis, R_dis, F_dis);
     end
     
     % robot cmd input
     [ w_l,w_r] = Diff_Robot_Model(w_lc, w_rc, sim_delta);
     
     % odometry
     [xn_pos,yn_pos,thetan]= Odometry(w_l, w_r, sim_delta,xp_pos,yp_pos, thetap,[R L]);
     xp_pos=xn_pos ;yp_pos=yn_pos; thetap=thetan;
 
     % filling the plot vectors 
     vect_x=[vect_x xp_pos];
     vect_y=[vect_y yp_pos];
     vect_theta=[vect_theta thetap];
     vect_t=[vect_t t];
     
       
 t=t+sim_delta;
 if(t>t_final)
     break
 end
end 
 
   figure(1)
   plot(vect_x,vect_y);
   title('robot position');
   xlabel('x(m)'); 
   ylabel('y(m)');

   draw_PFE3(vect_x, vect_y,vect_theta,vect_t,x_init,y_init)
   
%pause()
%visualization_vect(vect_x, vect_y,vect_theta,vect_t,min_range,max_range, obs1, obs2, obs3, obs4)

