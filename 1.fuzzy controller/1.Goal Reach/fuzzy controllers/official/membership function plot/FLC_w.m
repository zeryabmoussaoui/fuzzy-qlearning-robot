% D_error = {Z, NZ, P, M, NF, F, VF}
% theta_error = {N, SN, NNZ, Z, P, NPZ, SP, P}
% L = {Z, S, NM, M, NH, H, VH}
% R = {Z, S, NM, M, NH, H, VH}

clear
clc


%% plot the membership functions of the output
% D_error
vect_D_Z= [];
vect_D_NZ= [];
vect_D_P= [];
vect_D_M= [];
vect_D_NF= [];
vect_D_F= [];
vect_D_VF= [];

% theta error
vect_theta_N=[];
vect_theta_SN=[];
vect_theta_NNZ=[];
vect_theta_Z=[];
vect_theta_NPZ=[];
vect_theta_SP=[];
vect_theta_P=[];


vect_td=[];
vect_ta=[];
for td=0:0.01:2 

    D_Z= trianglar_fct( 0, 0.05,0 , td, 'start');
    D_NZ= trianglar_fct( 0.01,0.25,0.5 , td, 'tria');
    D_P= trianglar_fct( 0.25,0.5 ,0.75 , td, 'tria');
    D_M= trianglar_fct( 0.5,0.75 ,1 , td, 'tria');
    D_NF= trianglar_fct( 0.75,1,1.25 , td, 'tria');
    D_F= trianglar_fct( 1 , 1.25, 1.5 , td, 'tria');
    D_VF= trianglar_fct( 1.25,1.5 ,0 , td, 'end');
    
    
    
    
    vect_D_Z = [vect_D_Z D_Z ];
    vect_D_NZ= [vect_D_NZ D_NZ];
    vect_D_P= [vect_D_P D_P];
    vect_D_M= [vect_D_M D_M ];
    vect_D_NF= [vect_D_NF D_NF];
    vect_D_F= [vect_D_F D_F ];
    vect_D_VF= [vect_D_VF D_VF];
    
    vect_td=[vect_td td];
end

for ta=-90:0.1:90
    vect_ta=[vect_ta ta];
    % deg ->
    ta=ta*(pi/180);

    theta_N= trianglar_fct( -60*(pi/180), -40*(pi/180),0 , ta, 'start');
    theta_SN= trianglar_fct( -50*(pi/180), -30*(pi/180), -15*(pi/180) , ta, 'tria');
    theta_NNZ= trianglar_fct( -20*(pi/180), -5*(pi/180), -0.2*(pi/180) , ta, 'tria');
    theta_Z= trianglar_fct( -2*(pi/180), 0, 2*(pi/180) , ta, 'tria');
    theta_NPZ= trianglar_fct( 0.2*(pi/180), 5*(pi/180), 20*(pi/180) , ta, 'tria');
    theta_SP= trianglar_fct( 15*(pi/180), 30*(pi/180), 50*(pi/180) , ta, 'tria');
    theta_P= trianglar_fct( 40*(pi/180), 60*(pi/180), 0 , ta, 'end');
    
    vect_theta_N=[vect_theta_N theta_N];
    vect_theta_SN=[vect_theta_SN theta_SN];
    vect_theta_NNZ=[vect_theta_NNZ theta_NNZ ];
    vect_theta_Z=[vect_theta_Z theta_Z];
    vect_theta_NPZ=[vect_theta_NPZ theta_NPZ];
    vect_theta_SP=[vect_theta_SP theta_SP];
    vect_theta_P=[vect_theta_P theta_P];
    
    
end
figure(1)
plot(vect_td, vect_D_Z, vect_td, vect_D_NZ,'k', vect_td,vect_D_P, vect_td, vect_D_M, vect_td, vect_D_NF, vect_td, vect_D_F,vect_td,vect_D_VF)
legend('Z','NZ','P','M','NF','F','VF');
axis([0 2 0 1.2]);
xlabel('distance error (m)')


figure(2)
plot(vect_ta,vect_theta_N,vect_ta, vect_theta_SN,vect_ta, vect_theta_NNZ,vect_ta, vect_theta_Z,vect_ta,vect_theta_NPZ,vect_ta,vect_theta_SP,vect_ta,vect_theta_P)
legend('N','SN','NNZ','Z','NPZ','SP','P');
axis([-90 90 0 1.2])
xlabel('Angle error')

%% plot the membership functions of the output
 R_Z=0; R_S=1.5; R_NM=3; R_M=5; R_NH=7; R_H=10; R_VH=15;
 L_Z= R_Z; L_S= R_S; L_NM= R_NM; L_M= R_M; L_NH= R_NH; L_H= R_H; L_VH= R_VH;
 y=0:0.1:1;
 x=ones(1,length(y));
 
figure(3)
plot(R_Z.*x, y, R_S.*x ,y ,R_NM.*x,y ,R_M.*x,y, R_NH.*x, y, R_H.*x, y, R_H.*x, y, R_VH.*x,y );
legend('Z','S','NM','M','M','NH','H','VH');
axis([-0.1 16 0 1.2]);
xlabel(' right wheel velocity membership functions  ')

figure(4)
plot(L_Z.*x, y, L_S.*x ,y ,L_NM.*x,y ,L_M.*x,y, L_NH.*x, y, L_H.*x, y, L_H.*x, y, L_VH.*x,y );
legend('Z','S','NM','M','M','NH','H','VH');
axis([-0.1 16 0 1.2]);
xlabel(' left wheel velocity membership functions  ')
 
 