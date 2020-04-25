function draw_PFE3(vect_x_cur, vect_y_cur,vect_theta_cur,vect_t,x_init,y_init)

% draw the chamber
    d=0.1; x0=0; xf=4.5; y0=0; yf=4.5;
    rectangle('Position',[x0-d y0-d  (yf-y0)+2*d d]','FaceColor','k');  % lower border
    rectangle('Position',[x0-d yf  (yf-y0)+2*d d]','FaceColor','k');    % upper border 
    rectangle('Position',[x0-d y0-d  d (yf-y0)+2*d ]','FaceColor','k'); % left boder
    rectangle('Position',[xf y0-d  d (yf-y0)+2*d ]','FaceColor','k');   % right border
    axis([x0-0.2 xf+0.2 y0-0.2 yf+0.2]);
    axis equal
    hold on

% draw the initial positon and the final position
    rectangle('Position',[x_init-0.1 y_init-0.1 0.2 0.2]','Curvature',[1 1],'FaceColor','g');
    hold on
    
% draw obstacles
    x_ob1=1; y_ob1=1.5; r_ob1=0.25;
    %x_ob2=3.3; y_ob2=2.9; r_ob2=0.25;   %% r of the obstacles must be more than 0.2
    x_ob2=3.3; y_ob2=2.7; r_ob2=0.28;
    %x_ob3=2.2; y_ob3=1.7; r_ob3=0.25;
    x_ob3=2.2; y_ob3=1.5; r_ob3=0.28;
    x_ob4=2.1; y_ob4=2.7; r_ob4=0.25;
 
     rectangle('Position',[x_ob1-r_ob1 y_ob1-r_ob1 2*r_ob1 2*r_ob1]','Curvature',[1 1],'FaceColor','k');
     hold on
     rectangle('Position',[x_ob2-r_ob2 y_ob2-r_ob2 2*r_ob2 2*r_ob2]','Curvature',[1 1],'FaceColor','k');
     hold on
     rectangle('Position',[x_ob3-r_ob3 y_ob3-r_ob3 2*r_ob3 2*r_ob3]','Curvature',[1 1],'FaceColor','k');
     hold on
     rectangle('Position',[x_ob4-r_ob4 y_ob4-r_ob4 2*r_ob4 2*r_ob4]','Curvature',[1 1],'FaceColor','k');
     hold on

% draw the robot trajectory 
for i=1:4:length(vect_t)

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

end