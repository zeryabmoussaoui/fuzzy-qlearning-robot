function visualization_vect(vect_x_cur, vect_y_cur,vect_theta_cur,vect_t)

close all;
i_final=length(vect_x_cur);
t_max=vect_t(length(vect_t));

for i=1:5:i_final
% the position and trajectory  
    subplot(1,2,1);
    % plot the trajectory
    plot(vect_x_cur(1:i), vect_y_cur(1:i));
    axis([-1.2 1.2 -1.2 3.5]);
    xlabel('X coordinates (m)');
    ylabel('Y coordinates (m)')
    hold on
    
    % Robot plotting (x,y) the robot radius is 0.09 m
    rectangle('Position',[vect_x_cur(i)-0.09 vect_y_cur(i)-0.09 0.18 0.18]','Curvature',[1 1],'FaceColor','c');
    
    % direction polotting theta 
    pt_rot=0:0.01:0.09;
    plot(vect_x_cur(i)+pt_rot*cos(vect_theta_cur(i)),vect_y_cur(i)+pt_rot*sin(vect_theta_cur(i)),'r','LineWidth', 3);
    axis equal
    grid on
    grid minor
    hold off;
    
%%  plot x(t)
    subplot(3,2,2);
    plot(vect_t(1:i), vect_x_cur(1:i));
    axis([0 t_max 0 1.2]);
    xlabel('t (s)');
    ylabel('x  (m)')
    hold off

%% plot y(t)
    subplot(3,2,4);
    plot(vect_t(1:i), vect_y_cur(1:i));
    axis([0 t_max 0 1.2]);
    xlabel('t (s)');
    ylabel('y  (m)')
    hold off


%% plot theta(t)

    subplot(3,2,6);
    plot(vect_t(1:i), vect_theta_cur(1:i));
    axis([0 t_max -pi pi]);
    xlabel('t (s)');
    ylabel('theta  (m)')
    hold off
    
    pause(0.00000000001)
end
end
