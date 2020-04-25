function [W_Lc,W_Rc ]= fuzzy_controller_RL(d_error,theta_error,Actions)

% fuzzyfication
    D_Z= trianglar_fct( 0.00, 0.02,0 , d_error, 'start');   
    D_NZ= trianglar_fct( 0.01 ,0.15,0.3 , d_error, 'tria');
    D_M= trianglar_fct( 0.25,0.5 ,0.75 , d_error, 'tria');
    D_F= trianglar_fct( 0.7, 1 ,0 , d_error, 'end');
    
    theta_N= trianglar_fct( -30*(pi/180), -10*(pi/180),0 , theta_error, 'start');
    theta_SN= trianglar_fct( -15*(pi/180), -4*(pi/180), -1*(pi/180) , theta_error, 'tria');
    theta_Z= trianglar_fct( -1.5*(pi/180), 0, 1.5*(pi/180) , theta_error, 'tria');  % 1 -->1.5
    theta_SP= trianglar_fct( 1*(pi/180), 4*(pi/180), 15*(pi/180) , theta_error, 'tria');
    theta_P= trianglar_fct( 10*(pi/180), 30*(pi/180), 0 , theta_error, 'end');

% activation degree
    Ad=zeros(4,5);
    Ad(1,1)=min([ D_Z theta_N]);
    Ad(1,2)=min([ D_Z theta_SN]);
    Ad(1,3)=min([ D_Z theta_Z]);
    Ad(1,4)=min([ D_Z theta_SP]);
    Ad(1,5)=min([ D_Z theta_P]);
    
    
    Ad(2,1)=min([ D_NZ theta_N]);
    Ad(2,2)=min([ D_NZ theta_SN]);
    Ad(2,3)=min([ D_NZ theta_Z]);
    Ad(2,4)=min([ D_NZ theta_SP]);
    Ad(2,5)=min([ D_NZ theta_P]);
    
    
    Ad(3,1)=min([ D_M theta_N]);
    Ad(3,2)=min([ D_M theta_SN]);
    Ad(3,3)=min([ D_M theta_Z]);
    Ad(3,4)=min([ D_M theta_SP]);
    Ad(3,5)=min([ D_M theta_P]);

    
    Ad(4,1)=min([ D_F theta_N]);
    Ad(4,2)=min([ D_F theta_SN]);
    Ad(4,3)=min([ D_F theta_Z]);
    Ad(4,4)=min([ D_F theta_SP]);
    Ad(4,5)=min([ D_F theta_P]);
    
    [A_L_Z, A_L_M, A_L_H, A_R_Z, A_R_M, A_R_H]=Act_deg_conclusion_tab(Ad, Actions);
    
    R_Z=0;
    R_M=1.5;
    R_H=4;

    
    L_Z= R_Z;
    L_M= R_M;
    L_H= R_H;

    
    W_Rc= (A_L_Z*L_Z + A_L_M*L_M +  A_L_H*L_H )/3;
    W_Lc= (A_R_Z*R_Z + A_R_M*R_M +  A_R_H*R_H )/3;


end