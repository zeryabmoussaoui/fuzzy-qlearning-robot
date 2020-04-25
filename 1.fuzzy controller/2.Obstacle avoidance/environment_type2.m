function [ wall_u wall_d] = environment_type2()
 pt=0:0.01:2*pi;  % use 0.01 becuase there are some flaws when using 0.05
 xr=0;
 yr=0;
 ru=3;
 rd=4.2;
 xu= xr+ru*cos(pt);
 yu= yr+ru*sin(pt);
 xd= xr+rd*cos(pt);
 yd= yr+rd*sin(pt);
 
 wall_u=[xu; yu];
 wall_d=[xd; yd];
 
 plot(wall_u(1,:),wall_u(2,:),'b',wall_d(1,:),wall_d(2,:),'b');
 axis equal
 hold on

end