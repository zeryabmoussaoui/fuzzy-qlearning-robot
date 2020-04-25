close all
clear all;
clc;

% robot parameters 
R = 0.035; L = 0.28;

% simulation parameters 
sim_delta = 0.1;   
t=0;
t_final=100;
 
% var for initialization
x_init=0; y_init=0; theta_init=0;
xp=x_init ;yp=y_init; thetap=theta_init;
 
% vectors for plotting
vect_t=[];
vect_wl=[];
vect_wr=[];
vect_x=[];
vect_y=[];
vect_theta=[];
 
% desired position
x_d=5; y_d=0;

 
 while(1)
   % error calclation
   [d_error, theta_error]= Error(xp, yp, thetap, x_d, y_d);

   % fuzzy controller ( wheel speed)
   %[w_lc,w_rc ]= fuzzy_controller_simple(d_error,theta_error);
   [w_lc,w_rc ]= fuzzy_controller_w(d_error,theta_error);


   % robot cmd input
   [ w_l,w_r] = Diff_Robot_Model(w_lc, w_rc, sim_delta);
     
     
   % odometry
   [xn,yn,thetan]= Odometry(w_l, w_r, sim_delta,xp,yp, thetap,[R L]);
   xp=xn ;yp=yn; thetap=thetan;
     
     
 
   % filling the plot vectors 
   vect_wl=[vect_wl w_l];
   vect_wr=[vect_wr w_r];
   vect_t=[vect_t t];
   vect_x=[vect_x xp];
   vect_y=[vect_y yp];
   vect_theta=[vect_theta thetap];
       
 t=t+sim_delta;
 if(t>t_final)
     break
 end
 end 
 
figure(1) 
subplot(2,1,1); plot(vect_t,vect_wr,'r'); title('speed conrol r'); xlabel('w'); ylabel('t');
subplot(2,1,2); plot(vect_t,vect_wl,'r'); title('speed conrol l'); xlabel('w'); ylabel('t');

figure(2) 
subplot(3,1,1); plot(vect_t,vect_x,'r'); title('position x'); xlabel('x(m)'); ylabel('t');
subplot(3,1,2); plot(vect_t,vect_y,'r'); title('positon y'); xlabel('y(m)'); ylabel('t');
subplot(3,1,3); plot(vect_t,vect_theta,'r'); title('angle theta'); xlabel('theta(rad)'); ylabel('t');

figure(3)
plot(vect_x,vect_y);
title('robot position');
xlabel('x(m)'); 
ylabel('y(m)');
  
%pause()
%visualization_vect(vect_x, vect_y,vect_theta,vect_t)