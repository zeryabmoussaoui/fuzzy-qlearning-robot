function visualization_vect(vect_x_cur, vect_y_cur,vect_theta_cur,vect_t,min_range,max_range, uwall, dwall)

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
    rectangle('Position',[vect_x_cur(i)-0.09 vect_y_cur(i)-0.09 0.18 0.18]','Curvature',[1 1],'FaceColor','c');
    
    % plot sensor 
    [L_sensor R_sensor F_sensor]= sensors_pos(vect_x_cur(i),vect_y_cur(i),vect_theta_cur(i),min_range,max_range);
    plot(F_sensor(1,:),F_sensor(2,:),'g--',R_sensor(1,:),R_sensor(2,:),'g--',L_sensor(1,:),L_sensor(2,:),'g--');
    
    % plot env
    plot(dwall(1,:),dwall(2,:),'b',uwall(1,:),uwall(2,:),'b');
    %axis([x0-0.5 xf+0.5 y0-0.5 yf+0.5]);
    
    % plotting theta
    pt_rot=0:0.01:0.09;
    plot(vect_x_cur(i)+pt_rot*cos(vect_theta_cur(i)),vect_y_cur(i)+pt_rot*sin(vect_theta_cur(i)),'r','LineWidth', 3);
    axis equal
    %grid on
    %grid minor
    hold off;
    
    pause(0.00000000001)
end
end
