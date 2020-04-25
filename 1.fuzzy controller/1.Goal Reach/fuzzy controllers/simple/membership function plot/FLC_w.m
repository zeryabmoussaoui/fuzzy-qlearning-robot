%% Goal_reach fuzzy controller 
% D_error = {Z, NZ, M, F}
% theta_error = {N, SN, Z, SP , P}
% L = {Z, M, H}
% R = {Z, M, H}

clear
clc


%% plot the membership functions of the output
% D_error
vect_D_Z= [];
vect_D_NZ= [];
vect_D_M= [];
vect_D_F= [];

% theta error
vect_theta_N=[];
vect_theta_SN=[];
vect_theta_Z=[];
vect_theta_SP=[];
vect_theta_P=[];


vect_td=[];
vect_ta=[];
for td=0:0.01:2 
    
    D_Z= trianglar_fct( 0.00, 0.02,0 , td, 'start');   
    D_NZ= trianglar_fct( 0.01 ,0.15,0.3 , td, 'tria');
    D_M= trianglar_fct( 0.25,0.5 ,0.75 , td, 'tria');
    D_F= trianglar_fct( 0.7, 1 ,0 , td, 'end');
    
    
    
    
    vect_D_Z = [vect_D_Z D_Z ];
    vect_D_NZ= [vect_D_NZ D_NZ];
    vect_D_M= [vect_D_M D_M ];
    vect_D_F= [vect_D_F D_F ];

    vect_td=[vect_td td];
end

for ta=-90:0.1:90
    vect_ta=[vect_ta ta];
    % deg ->
    ta=ta*(pi/180);
    
    theta_N= trianglar_fct( -30*(pi/180), -10*(pi/180),0 , ta, 'start');
    theta_SN= trianglar_fct( -15*(pi/180), -4*(pi/180), -1*(pi/180) , ta, 'tria');
    theta_Z= trianglar_fct( -1.5*(pi/180), 0, 1.5*(pi/180) , ta, 'tria');  % 1 -->1.5
    theta_SP= trianglar_fct( 1*(pi/180), 4*(pi/180), 15*(pi/180) , ta, 'tria');
    theta_P= trianglar_fct( 10*(pi/180), 30*(pi/180), 0 , ta, 'end');
    
    vect_theta_N=[vect_theta_N theta_N];
    vect_theta_SN=[vect_theta_SN theta_SN];
    vect_theta_Z=[vect_theta_Z theta_Z];
    vect_theta_SP=[vect_theta_SP theta_SP];
    vect_theta_P=[vect_theta_P theta_P];
    
    
end


% theta_error = {N, SN, Z, SP , P}

figure(1)
plot(vect_td, vect_D_Z, vect_td, vect_D_NZ,'k',vect_td, vect_D_M, vect_td, vect_D_F)
legend('Z','NZ','M','F');
axis([0 2 0 1.2]);
xlabel('distance error (m)')


figure(2)
plot(vect_ta,vect_theta_N,vect_ta, vect_theta_SN,vect_ta, vect_theta_Z,vect_ta,vect_theta_SP,vect_ta,vect_theta_P)
legend('N','SN','Z','SP','P');
axis([-90 90 0 1.2])
xlabel('Angle error')

%% plot the membership functions of the output
     R_Z=0;
     R_M=2;
     R_H=4;

    
    L_Z= R_Z;
    L_M= R_M;
    L_H= R_H;
 
 
 y=0:0.1:1;
 x=ones(1,length(y));
 
figure(3)
plot(R_Z.*x, y,R_M.*x,y, R_H.*x, y);
legend('Z','M','H');
axis([-0.1 16 0 1.2]);
xlabel(' right wheel velocity membership functions  ')

figure(4)
plot(L_Z.*x, y, L_M.*x, y, L_H.*x, y);
legend('Z','M','H');
axis([-0.1 16 0 1.2]);
xlabel(' left wheel velocity membership functions  ')
 
 