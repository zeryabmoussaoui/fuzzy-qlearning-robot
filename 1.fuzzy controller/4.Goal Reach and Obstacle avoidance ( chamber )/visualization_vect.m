function visualization_vect(vect_x_cur, vect_y_cur,vect_theta_cur,vect_t,min_range,max_range, obs1, obs2, obs3, obs4)

close all;
i_final=length(vect_x_cur);
t_max=vect_t(length(vect_t));

for i=1:5:i_final
% the position and trajectory  
 
    % plot the trajectory
    plot(vect_x_cur(1:i), vect_y_cur(1:i));
    xlabel('X coordinates (m)');
    ylabel('Y coordinates (m)')
    hold on
    
    % Robot plotting (x,y) the robot radius is 0.09 m
    rectangle('Position',[vect_x_cur(i)-0.1 vect_y_cur(i)-0.1 0.2 0.2]','Curvature',[1 1],'FaceColor','c');
    
    % plot sensor 
    [L_sensor R_sensor F_sensor]= sensors_pos(vect_x_cur(i),vect_y_cur(i),vect_theta_cur(i),min_range,max_range);
    plot(F_sensor(1,:),F_sensor(2,:),'g--',R_sensor(1,:),R_sensor(2,:),'g--',L_sensor(1,:),L_sensor(2,:),'g--');
    
    % plot env
    plot(obs1(1,:),obs1(2,:),'b',obs2(1,:),obs2(2,:),'b',obs3(1,:),obs3(2,:),'b',obs4(1,:),obs4(2,:),'b');
    
    
    % plotting theta
    pt_rot=0:0.01:0.09;
    plot(vect_x_cur(i)+pt_rot*cos(vect_theta_cur(i)),vect_y_cur(i)+pt_rot*sin(vect_theta_cur(i)),'r','LineWidth', 3);
    axis equal
    %grid on
    %grid minor
    hold off;
    
    % plot env
    d=0.1;
    x0=0;
    xf=4.5;
    y0=0;
    yf=4.5;
    rectangle('Position',[x0-d y0-d  (yf-y0)+2*d d]','FaceColor','k');  % lower border
    rectangle('Position',[x0-d yf  (yf-y0)+2*d d]','FaceColor','k');    % upper border 
    rectangle('Position',[x0-d y0-d  d (yf-y0)+2*d ]','FaceColor','k'); % left boder
    rectangle('Position',[xf y0-d  d (yf-y0)+2*d ]','FaceColor','k');   % right border
    axis([x0-0.2 xf+0.2 y0-0.2 yf+0.2]);
    
 x_ob1=1; y_ob1=1.5; r_ob1=0.25;
 x_ob2=3.3; y_ob2=2.9; r_ob2=0.25;   %% r of the obstacles must be more than 0.2
 x_ob3=2.2; y_ob3=1.7; r_ob3=0.25;
 x_ob4=2.3; y_ob4=3; r_ob4=0.25;
 
     rectangle('Position',[x_ob1-r_ob1 y_ob1-r_ob1 2*r_ob1 2*r_ob1]','Curvature',[1 1],'FaceColor','k');
     rectangle('Position',[x_ob2-r_ob2 y_ob2-r_ob2 2*r_ob2 2*r_ob2]','Curvature',[1 1],'FaceColor','k');
     rectangle('Position',[x_ob3-r_ob3 y_ob3-r_ob3 2*r_ob3 2*r_ob3]','Curvature',[1 1],'FaceColor','k');
     rectangle('Position',[x_ob4-r_ob4 y_ob4-r_ob4 2*r_ob4 2*r_ob4]','Curvature',[1 1],'FaceColor','k');
    pause(0.00000000001)
end
end
