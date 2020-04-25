%% Goal_reach fuzzy controller 
% D_error = {Z, NZ, P, M, NF, F, VF}
% theta_error = {N, NN, NNZ, Z, NPZ, SP , P}
% L = {Z, S, NM, M, NH, H, VH}
% R = {Z, S, NM, M, NH, H, VH}

function [W_Lc,W_Rc ]= fuzzy_controller_w(d_error,theta_error)

% fuzzyfication
%     D_Z= trianglar_fct( 0, 0.05,0 , d_error, 'start');
%     D_NZ= trianglar_fct( 0.03,0.07,0.1 , d_error, 'tria');
%     D_P= trianglar_fct( 0.07,0.1 ,0.15 , d_error, 'tria');
%     D_M= trianglar_fct( 0.1,0.15 ,0.3 , d_error, 'tria');
%     D_NF= trianglar_fct( 0.15,0.3,0.5 , d_error, 'tria');
%     D_F= trianglar_fct( 0.3,0.5 ,1 , d_error, 'tria');
%     D_VF= trianglar_fct( 0.5,1 ,0 , d_error, 'end');

%     D_Z= trianglar_fct( 0, 0.05,0 , d_error, 'start');
%     D_NZ= trianglar_fct( 0.05,0.1,0.15 , d_error, 'tria');
%     D_P= trianglar_fct( 0.1,0.3 ,0.5 , d_error, 'tria');
%     D_M= trianglar_fct( 0.4,0.6 ,0.8 , d_error, 'tria');
%     D_NF= trianglar_fct( 0.7,0.9,1.1 , d_error, 'tria');
%     D_F= trianglar_fct( 1,1.2 ,1.4, d_error, 'tria');
%     D_VF= trianglar_fct( 1.2,1.5 ,0 , d_error, 'end');


%     D_Z= trianglar_fct( 0, 0.05,0 , d_error, 'start');
%     D_NZ= trianglar_fct( 0.01,0.1,0.15 , d_error, 'tria');
%     D_P= trianglar_fct( 0.1,0.3 ,0.5 , d_error, 'tria');
%     D_M= trianglar_fct( 0.4,0.6 ,0.8 , d_error, 'tria');
%     D_NF= trianglar_fct( 0.7,0.9,1.1 , d_error, 'tria');
%     D_F= trianglar_fct( 1,1.2 ,1.4, d_error, 'tria');
%     D_VF= trianglar_fct( 1.2,1.5 ,0 , d_error, 'end');

    D_Z= trianglar_fct( 0, 0.05,0 , d_error, 'start');
    D_NZ= trianglar_fct( 0.01,0.25,0.5 , d_error, 'tria');
    D_P= trianglar_fct( 0.25,0.5 ,0.75 , d_error, 'tria');
    D_M= trianglar_fct( 0.5,0.75 ,1 , d_error, 'tria');
    D_NF= trianglar_fct( 0.75,1,1.25 , d_error, 'tria');
    D_F= trianglar_fct( 1 , 1.25, 1.5 , d_error, 'tria');
    D_VF= trianglar_fct( 1.25,1.5 ,0 , d_error, 'end');

    
    
%     theta_N= trianglar_fct( -30*(pi/180), -10*(pi/180),0 , theta_error, 'start');
%     theta_SN= trianglar_fct( -15*(pi/180), -7*(pi/180), -3*(pi/180) , theta_error, 'tria');
%     theta_NNZ= trianglar_fct( -4*(pi/180), -2*(pi/180), -0.5*(pi/180) , theta_error, 'tria');
%     theta_Z= trianglar_fct( -1*(pi/180), 0, 1*(pi/180) , theta_error, 'tria');
%     theta_NPZ= trianglar_fct( 0.5*(pi/180), 2*(pi/180), 4*(pi/180) , theta_error, 'tria');
%     theta_SP= trianglar_fct( 3*(pi/180), 7*(pi/180), 15*(pi/180) , theta_error, 'tria');
%     theta_P= trianglar_fct( 10*(pi/180), 30*(pi/180), 0 , theta_error, 'end');
    
    theta_N= trianglar_fct( -60*(pi/180), -40*(pi/180),0 , theta_error, 'start');
    theta_SN= trianglar_fct( -50*(pi/180), -30*(pi/180), -15*(pi/180) , theta_error, 'tria');
    theta_NNZ= trianglar_fct( -20*(pi/180), -5*(pi/180), -0.2*(pi/180) , theta_error, 'tria');
    theta_Z= trianglar_fct( -2*(pi/180), 0, 2*(pi/180) , theta_error, 'tria');
    theta_NPZ= trianglar_fct( 0.2*(pi/180), 5*(pi/180), 20*(pi/180) , theta_error, 'tria');
    theta_SP= trianglar_fct( 15*(pi/180), 30*(pi/180), 50*(pi/180) , theta_error, 'tria');
    theta_P= trianglar_fct( 40*(pi/180), 60*(pi/180), 0 , theta_error, 'end');

% activation degree rules
    Ad=zeros(7,7);
    Ad(1,1)=min([D_Z theta_N]);
    Ad(1,2)=min([D_Z theta_SN]);
    Ad(1,3)=min([D_Z theta_NNZ]);
    Ad(1,4)=min([D_Z theta_Z]);
    Ad(1,5)=min([D_Z theta_NPZ]);
    Ad(1,6)=min([D_Z theta_SP]);
    Ad(1,7)=min([D_Z theta_P]);
    
    Ad(2,1)=min([D_NZ theta_N]);
    Ad(2,2)=min([D_NZ theta_SN ]);
    Ad(2,3)=min([D_NZ theta_NNZ]);
    Ad(2,4)=min([D_NZ theta_Z]);
    Ad(2,5)=min([D_NZ theta_NPZ]);
    Ad(2,6)=min([D_NZ theta_SP]);
    Ad(2,7)=min([D_NZ theta_P]);
    
    Ad(3,1)=min([D_P theta_N]);
    Ad(3,2)=min([D_P theta_SN]);
    Ad(3,3)=min([D_P theta_NNZ]);
    Ad(3,4)=min([D_P theta_Z]);
    Ad(3,5)=min([D_P theta_NPZ]);
    Ad(3,6)=min([D_P theta_SP]);
    Ad(3,7)=min([D_P theta_P]);
    
    Ad(4,1)=min([D_M theta_N]);
    Ad(4,2)=min([D_M theta_SN]);
    Ad(4,3)=min([D_M theta_NNZ]);
    Ad(4,4)=min([D_M theta_Z]);
    Ad(4,5)=min([D_M theta_NPZ]);
    Ad(4,6)=min([D_M theta_SP]);
    Ad(4,7)=min([D_M theta_P]);
    
    Ad(5,1)=min([D_NF theta_N]);
    Ad(5,2)=min([D_NF theta_SN]);
    Ad(5,3)=min([D_NF theta_NNZ]);
    Ad(5,4)=min([D_NF theta_Z]);
    Ad(5,5)=min([D_NF theta_NPZ]);
    Ad(5,6)=min([D_NF theta_SP]);
    Ad(5,7)=min([D_NF theta_P]);
    
    Ad(6,1)=min([D_F theta_N]);
    Ad(6,2)=min([D_F theta_SN]);
    Ad(6,3)=min([D_F theta_NNZ]);
    Ad(6,4)=min([D_F theta_Z]);
    Ad(6,5)=min([D_F theta_NPZ]);
    Ad(6,6)=min([D_F theta_SP]);
    Ad(6,7)=min([D_F theta_P]);
    
    Ad(7,1)=min([D_VF theta_N]);
    Ad(7,2)=min([D_VF theta_SN]);
    Ad(7,3)=min([D_VF theta_NNZ]);
    Ad(7,4)=min([D_VF theta_Z]);
    Ad(7,5)=min([D_VF theta_NPZ]);
    Ad(7,6)=min([D_VF theta_SP]);
    Ad(7,7)=min([D_VF theta_P]);

 % rules activation (agrégation)
    A_R_Z=  max([Ad(1,1) Ad(1,2) Ad(1,3) Ad(1,4) Ad(2,3)]); %+
    A_R_S=  max([Ad(2,1) Ad(2,2) Ad(2,4) Ad(3,1) Ad(3,2) Ad(3,3) Ad(4,1) Ad(4,2) Ad(4,3) Ad(5,1) Ad(5,2) Ad(6,1) Ad(6,2) Ad(7,1) Ad(7,2)]); %+
    A_R_NM=  max([Ad(1,5) Ad(1,6) Ad(3,4) Ad(5,3) Ad(7,3)]); %+
    A_R_M=  max([Ad(1,7) Ad(2,5) Ad(4,4) Ad(6,3)]); %+
    %A_R_NH=  max([Ad(2,6) Ad(3,5) Ad(5,4) Ad(5,5) Ad(6,5) Ad(7,6)]);
    A_R_NH=  max([Ad(2,6) Ad(3,5) Ad(5,4) Ad(5,5) Ad(6,5) Ad(7,5)]);
    %A_R_H=  max([Ad(2,7) Ad(3,6) Ad(4,5) Ad(4,6) Ad(5,6) Ad(6,6) Ad(7,6)]);
    A_R_H=  max([Ad(2,7) Ad(3,6) Ad(4,5) Ad(4,6) Ad(5,6) Ad(6,4) Ad(6,6) Ad(7,6) ]); % Ad(6,4)
    A_R_VH=  max([Ad(3,7) Ad(4,7) Ad(5,7) Ad(6,7) Ad(7,4) Ad(7,7)]);
    
    A_L_Z=  max([Ad(1,4) Ad(1,5) Ad(1,6) Ad(1,7) Ad(2,5)]);
    %A_L_S=  max([Ad(2,6) Ad(2,7) Ad(3,5) Ad(3,6) Ad(3,7) Ad(4,5) Ad(4,6) Ad(4,7) Ad(5,6) Ad(5,7) Ad(6,6) Ad(6,7) Ad(7,6) Ad(7,7)]); %+ Ad(2,4)
    A_L_S=  max([Ad(2,4) Ad(2,6) Ad(2,7) Ad(3,5) Ad(3,6) Ad(3,7) Ad(4,5) Ad(4,6) Ad(4,7) Ad(5,6) Ad(5,7) Ad(6,6) Ad(6,7) Ad(7,6) Ad(7,7)]); %+ 
    A_L_NM=  max([Ad(1,2) Ad(1,3) Ad(3,4) Ad(5,5) Ad(7,5)]);
    A_L_M=  max([Ad(1,1) Ad(2,3) Ad(4,4) Ad(6,5)]);
    A_L_NH=  max([Ad(2,2) Ad(3,3) Ad(5,3) Ad(5,4) Ad(6,3) Ad(7,3)]);
    A_L_H=  max([Ad(2,1) Ad(3,2) Ad(4,2) Ad(4,3) Ad(5,2) Ad(6,2) Ad(6,4) Ad(7,2)]);
    %A_L_VH=  max([Ad(3,1) Ad(4,1) Ad(5,1) Ad(6,1) Ad(7,1)]); % Ad(7,4)
    A_L_VH=  max([Ad(3,1) Ad(4,1) Ad(5,1) Ad(6,1) Ad(7,1) Ad(7,4)]); % Ad(7,4)
    
    %R = {Z, S, NM, M, NH, H, VH}
    R_Z=0;
    R_S=1.5;
    R_NM=3;
    R_M=5;
    R_NH=7;
    R_H=10;
    R_VH=15;

    L_Z= R_Z;
    L_S= R_S;
    L_NM= R_NM;
    L_M= R_M;
    L_NH= R_NH;
    L_H= R_H;
    L_VH= R_VH;
    
%     Méthode du centre de gravité    
    %W_Lc= (A_L_Z*L_Z + A_L_S*L_S + A_L_NM*L_NM + A_L_M*L_M + A_L_NH*L_NH + A_L_H*L_H + A_L_VH*L_VH)/(A_L_Z+ A_L_S+A_L_NM+A_L_M+A_L_NH+A_L_H+A_L_VH);
    %W_Rc= (A_R_Z*R_Z + A_R_S*R_S + A_R_NM*R_NM + A_R_M*R_M + A_R_NH*R_NH + A_R_H*R_H + A_R_VH*R_VH)/(A_R_Z+ A_R_S+A_R_NM+A_R_M+A_R_NH+A_R_H+A_R_VH);
    
    % Méthode de la moyenne des maxima
    W_Lc= (A_L_Z*L_Z + A_L_S*L_S + A_L_NM*L_NM + A_L_M*L_M + A_L_NH*L_NH + A_L_H*L_H + A_L_VH*L_VH)/7;
    W_Rc= (A_R_Z*R_Z + A_R_S*R_S + A_R_NM*R_NM + A_R_M*R_M + A_R_NH*R_NH + A_R_H*R_H + A_R_VH*R_VH)/7;
    
    
    
    
end