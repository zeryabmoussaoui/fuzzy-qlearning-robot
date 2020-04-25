function [wall_d wall_u wall_l wall_r obs1 obs2 obs3 obs4 ]= obstacles_chamber()


%% the borders 
x0=0;
xf=4.5;
y0=0;
yf=4.5;
delta=0.1;

% the lower borders 
x_wall_d=x0:delta:xf;
y_wall_d=y0*ones(1,length(x_wall_d));
wall_d=[x_wall_d;y_wall_d];

% the upper borders 
x_wall_u=x0:delta:xf;
y_wall_u=yf*ones(1,length(x_wall_u));
wall_u=[x_wall_u;y_wall_u];

% the left wall 
y_wall_l= y0:0.1:yf;
x_wall_l= x0*ones(1,length(y_wall_l));
wall_l=[x_wall_l;y_wall_l];

% the right wall
y_wall_r=y0:0.1:yf;
x_wall_r=xf*ones(1,length(y_wall_r));
wall_r=[x_wall_r; y_wall_r];

% plot
plot(wall_d(1,:),wall_d(2,:),wall_u(1,:),wall_u(2,:),wall_r(1,:),wall_r(2,:),wall_l(1,:),wall_l(2,:));
axis([x0-0.2 xf+0.2 y0-0.2 yf+0.2]);

%% obstacles
 pt=0:0.01:2*pi;  % use 0.01 becuase there are some flaws when using 0.05
 
 x_ob1=1; y_ob1=1.5; r_ob1=0.25;
 %x_ob2=3.3; y_ob2=2.9; r_ob2=0.25;
 x_ob2=3.3; y_ob2=2.7; r_ob2=0.28;
 %x_ob3=2.2; y_ob3=1.7; r_ob3=0.25;
 x_ob3=2.2; y_ob3=1.5; r_ob3=0.28;
 x_ob4=2.1; y_ob4=2.7; r_ob4=0.25;
 
 
 obs1=[x_ob1+r_ob1*cos(pt); y_ob1+r_ob1*sin(pt)];
 obs2=[x_ob2+r_ob2*cos(pt); y_ob2+r_ob2*sin(pt)];
 obs3=[x_ob3+r_ob3*cos(pt); y_ob3+r_ob3*sin(pt)];
 obs4=[x_ob4+r_ob4*cos(pt); y_ob4+r_ob4*sin(pt)];
 
 plot(obs1(1,:),obs1(2,:),obs2(1,:),obs2(2,:),obs3(1,:),obs3(2,:),obs4(1,:),obs4(2,:));



%% draw rectangles 
% borders 
d=0.1;
% rectangle('Position',[x0-d y0-d  (yf-y0)+2*d d]','FaceColor','k');  % lower border
% rectangle('Position',[x0-d yf  (yf-y0)+2*d d]','FaceColor','k');    % upper border 
% rectangle('Position',[x0-d y0-d  d (yf-y0)+2*d ]','FaceColor','k'); % left boder
% rectangle('Position',[xf y0-d  d (yf-y0)+2*d ]','FaceColor','k');   % right border

% obstacles 
% rectangle('Position',[x_ob1-r_ob1 y_ob1-r_ob1 2*r_ob1 2*r_ob1]','Curvature',[1 1],'FaceColor','k');
% rectangle('Position',[x_ob2-r_ob2 y_ob2-r_ob2 2*r_ob2 2*r_ob2]','Curvature',[1 1],'FaceColor','k');
% rectangle('Position',[x_ob3-r_ob3 y_ob3-r_ob3 2*r_ob3 2*r_ob3]','Curvature',[1 1],'FaceColor','k');
% rectangle('Position',[x_ob4-r_ob4 y_ob4-r_ob4 2*r_ob4 2*r_ob4]','Curvature',[1 1],'FaceColor','k');
 
axis equal
hold on
end