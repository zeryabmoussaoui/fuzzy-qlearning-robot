function [ w_l,w_r] = Diff_Robot_Model(wd_l, wd_r, sim_delta)
%% DC Motor parameters
J =0.01; b = 0.1; K = 0.01; R = 1; L = 0.5;

A = [-b/J  K/J ; -K/L -R/L];
B = [ 0 ; 1/L];
C = [ 1 , 0];
K_f=[-0.0100    3.0000];

Max_speed = 0.025; % (rad/s);


% left motor
xl1=[0;0]; xr1=[0;0];
persistent xl;
if isempty(xl) 
        xl=[0;0];
        yl=C*xl;
        w_l=yl(1);
else
    Ul= wd_l/Max_speed;
    ul = -K_f*xl1+Ul;
    xl=xl+sim_delta*(A*xl+B*ul);
    yl=C*xl;
    w_l=yl(1);
end
% right motor

persistent xr;
if isempty(xr) 
        xr=[0;0];
        yr=C*xr;
        w_r=yr(1);
else
    Ur= wd_r/Max_speed;
    ur = -K_f*xr1+Ur;
    xr=xr+sim_delta*(A*xr+B*ur);
    yr=C*xr;
    w_r=yr(1);
end
end