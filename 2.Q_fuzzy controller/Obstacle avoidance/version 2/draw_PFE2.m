function draw_PFE2(vect_x_cur, vect_y_cur,vect_theta_cur,vect_t,x_init,y_init)

% draw the chamber
    xr=0; yr=0; rd=3 ; ru=4.2; rdp=2.8 ; rup=4.4;
    rectangle('Position',[xr-rup yr-rup  2*rup 2*rup]','Curvature',[1 1],'FaceColor','k');  % lower border
    hold on
    rectangle('Position',[xr-ru yr-ru  2*ru 2*ru]','Curvature',[1 1],'FaceColor','w');
    hold on
    rectangle('Position',[xr-rd yr-rd  2*rd 2*rd]','Curvature',[1 1],'FaceColor','k');
    hold on
    rectangle('Position',[xr-rdp yr-rdp  2*rdp 2*rdp]','Curvature',[1 1],'FaceColor','w');
    hold on
        
    axis equal
    hold on

% draw the initial positon and the final position
    rectangle('Position',[x_init-0.1 y_init-0.1 0.2 0.2]','Curvature',[1 1],'FaceColor','g');
    hold on

% draw the robot's trajectory and orientation   
for i=1:5:length(vect_t)

    % Robot plotting (x,y) the robot radius is 0.09 m
         % filled circle
    %rectangle('Position',[vect_x_cur(i)-0.1 vect_y_cur(i)-0.1 0.2 0.2]','Curvature',[1 1],'FaceColor','c');
         % empty circle
    rectangle('Position',[vect_x_cur(i)-0.1 vect_y_cur(i)-0.1 0.2 0.2]','Curvature',[1 1],'EdgeColor','b','LineWidth',0.5)     
    
    % orientation
    pt_rot=0:0.01:0.09;
    plot(vect_x_cur(i)+pt_rot*cos(vect_theta_cur(i)),vect_y_cur(i)+pt_rot*sin(vect_theta_cur(i)),'r','LineWidth', 1);
    hold on
    
end