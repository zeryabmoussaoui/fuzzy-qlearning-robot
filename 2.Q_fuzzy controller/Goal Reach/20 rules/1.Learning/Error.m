function [d_error, theta_error]= Error(x_cur, y_cur, theta_cur, x_des, y_des)
% distance error between the desired posiotion and the robot position   (m)
% angllur error between the desidered position and the robot position (rad)
% there is a problem concerning the angle atan ( -1,-1 or -1,1)
d_error= sqrt( (x_des-x_cur)^2+(y_des-y_cur)^2);
theta_error = atan2((y_des-y_cur),(x_des-x_cur))-theta_cur;
end