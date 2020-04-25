close all
clear;
clc;

%% Robot parameters
R = 0.035; L = 0.28;

% simulation parameters 
sim_delta = 0.1;   
t=0;
t_final=150;
 
% var for initialization
x_init=0; y_init=0; theta_init=0;
xp=x_init ;yp=y_init; thetap=theta_init; % inilial position and orientation
 
% vectors for plotting
vect_t=[];
% vectors for plotting the robot's coor unsing a FLC
    vect_X=[];
    vect_Y=[];
    vect_THETA=[];

% desired position
x_d=2; y_d=1;


for i=2000:2000:4000
    load(strcat('qtable',int2str(i)));
    policy=Q_policy(q);
    
    % plot vectors
    vect_x=[];
    vect_y=[];
    vect_theta=[];
    vect_t=[];
    
    for t=0:sim_delta:t_final
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

    end
    
    clear q;
     
    vect_X=[vect_X; vect_x];
    vect_Y=[vect_Y; vect_y];
    vect_THETA=[vect_THETA; vect_theta];
 end    
 
 
figure(1) 
subplot(3,1,1); plot(vect_t,vect_X(1,:),'r',vect_t,vect_X(2,:),'b'); title('position x'); xlabel('t'); ylabel('x(m)');legend('4000 itération','2000 itération');
subplot(3,1,2); plot(vect_t,vect_Y(1,:),'r',vect_t,vect_Y(2,:),'b'); title('positon y'); xlabel('t'); ylabel('y(m)');
subplot(3,1,3); plot(vect_t,vect_THETA(1,:),'r',vect_t,vect_THETA(2,:),'b'); title('angle theta'); xlabel('theta(rad)'); ylabel('t');

figure(2)
subplot(2,1,1);plot(vect_X(1,:),vect_Y(1,:)); title('policy 2000 itération');xlabel('x(m)'); ylabel('y(m)'); axis equal;
subplot(2,1,2);plot(vect_X(2,:),vect_Y(2,:)); title('policy 4000 itération');xlabel('x(m)'); ylabel('y(m)'); axis equal;