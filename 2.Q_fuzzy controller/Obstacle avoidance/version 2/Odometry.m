function [xn_pos,yn_pos,thetan]= Odometry(w_l, w_r, sim_delta,xp_pos,yp_pos, thetap,robot_par )
R=robot_par(1);
L=robot_par(2);
xn_pos= xp_pos + sim_delta*(R/2*(w_l+w_r)*cos(thetap));
yn_pos= yp_pos + sim_delta*(R/2*(w_l+w_r)*sin(thetap));
%thetan=thetap + sim_delta*(R/L*(w_r-w_l));
theta_inf= thetap + sim_delta*(R/L*(w_r-w_l));
 if (theta_inf<-2*pi)
      thetan = theta_inf+2*pi;
  else
      if(theta_inf> 2*pi)
          thetan = theta_inf-2*pi;
      else
          thetan = theta_inf;
          
      end
end
end