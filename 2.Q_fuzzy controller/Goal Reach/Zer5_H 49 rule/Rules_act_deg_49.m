function Rules_deg= Rules_act_deg_49(xp, yp, thetap, x_d, y_d)

[d_error, theta_error]= Error(xp, yp, thetap, x_d, y_d);

% fuzzyfication
    D_Z= trianglar_fct( 0, 0.05,0 , d_error, 'start');
    D_NZ= trianglar_fct( 0.01,0.25,0.5 , d_error, 'tria');
    D_P= trianglar_fct( 0.25,0.5 ,0.75 , d_error, 'tria');
    D_M= trianglar_fct( 0.5,0.75 ,1 , d_error, 'tria');
    D_NF= trianglar_fct( 0.75,1,1.25 , d_error, 'tria');
    D_F= trianglar_fct( 1 , 1.25, 1.5 , d_error, 'tria');
    D_VF= trianglar_fct( 1.25,1.5 ,0 , d_error, 'end');
    
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
    
    Rules_deg=Ad(:);

end