close all
clear;
clc;

%% Robot parameters
R = 0.035; L = 0.28;

%% the Policy 
load('qtable4000');
policy=Q_policy(q);

% simulation parameters 
sim_delta = 0.1;   
t=0;
t_final=300;
 
% var for initialization
x_init=0.0; y_init=0.0; theta_init=0;
xp=x_init ;yp=y_init; thetap=theta_init; % inilial position and orientation
 
% vectors for plotting
vect_t=[];
% vectors for plotting the robot's coor unsing a FLC
vect_x=[];
vect_y=[];
vect_theta=[];

% vectors for plotting the robot's coor unsing Q-FLC
vect_x_r=[];
vect_y_r=[];
vect_theta_r=[]; 
% desired position
x_d=1; y_d=-0.5;
 
%% FLC 
 while(1)
     % error calclation
     [d_error, theta_error]= Error(xp, yp, thetap, x_d, y_d);
     
     [w_lc,w_rc ]= fuzzy_controller_RL(d_error,theta_error,policy);
     
     % robot cmd input
     [ w_l,w_r] = Diff_Robot_Model(w_lc, w_rc, sim_delta);
     
     
     % odometry
     [xn,yn,thetan]= Odometry(w_l, w_r, sim_delta,xp,yp, thetap,[R L]);
     xp=xn ;yp=yn; thetap=thetan;
          
     % filling the plot vectors 
     vect_t=[vect_t t];
     vect_x=[vect_x xp];
     vect_y=[vect_y yp];
     vect_theta=[vect_theta thetap];
       
 t=t+sim_delta;
 if(t>t_final)
     break
 end
 end 

 %% Q-FLC
 t=0;
 xp=x_init ;yp=y_init; thetap=theta_init;
 
  while(1)
     % error calclation
     [d_error, theta_error]= Error(xp, yp, thetap, x_d, y_d);
     
     [w_lc,w_rc ]= fuzzy_controller_simple(d_error,theta_error);
     
     % robot cmd input
     [ w_l,w_r] = Diff_Robot_Model(w_lc, w_rc, sim_delta);
     
     
     % odometry
     [xn,yn,thetan]= Odometry(w_l, w_r, sim_delta,xp,yp, thetap,[R L]);
     xp=xn ;yp=yn; thetap=thetan;
          
     % filling the plot vectors 
     vect_x_r=[vect_x_r xp];
     vect_y_r=[vect_y_r yp];
     vect_theta_r=[vect_theta_r thetap];
       
 t=t+sim_delta;
 if(t>t_final)
     break
 end
 end 
 
figure(1) 
subplot(3,1,1); plot(vect_t,vect_x,'r',vect_t,vect_x_r,'b'); title('position x'); xlabel('t'); ylabel('x(m)');legend('Q-FLC','FLC');
subplot(3,1,2); plot(vect_t,vect_y,'r',vect_t,vect_y_r,'b'); title('positon y'); xlabel('t'); ylabel('y(m)');
subplot(3,1,3); plot(vect_t,vect_theta,'r',vect_t,vect_theta_r,'b'); title('angle theta'); xlabel('theta(rad)'); ylabel('t');

figure(2)
plot(vect_x,vect_y,'r',vect_x_r,vect_y_r,'b'); title('robot position'); xlabel('x(m)'); ylabel('y(m)');legend('Q-FLC','FLC')
