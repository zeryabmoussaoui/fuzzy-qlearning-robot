function [d_error, theta_error]= Error(x_cur, y_cur, theta_cur, x_des, y_des)

d_error= sqrt( (x_des-x_cur)^2+(y_des-y_cur)^2);

%atan(X) returns values in the interval [-pi/2,pi/2]
% atan2(a,b) maps in [-pi +pi]
theta_error = atan2((y_des-y_cur),(x_des-x_cur))-theta_cur;
end