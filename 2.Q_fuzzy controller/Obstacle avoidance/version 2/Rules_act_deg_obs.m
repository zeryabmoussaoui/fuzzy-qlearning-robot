function A=Rules_act_deg_obs(L_sensor, R_sensor, F_sensor)

    L_N= trianglar_fct( 0+0.1, 0.1+0.1 ,0 , L_sensor, 'start'); 
    L_M= trianglar_fct( 0.05+0.1,0.15+0.1 ,0.25+0.1 , L_sensor, 'tria'); 
    L_F= trianglar_fct( 0.25+0.1, 0.3+0.1 ,0 , L_sensor, 'end');    

    R_N= trianglar_fct( 0+0.1, 0.1+0.1 ,0 , R_sensor, 'start'); 
    R_M= trianglar_fct( 0.05+0.1,0.15+0.1 ,0.25+0.1 , R_sensor, 'tria'); 
    R_F= trianglar_fct( 0.25+0.1, 0.3+0.1 ,0 , R_sensor, 'end');    


    F_N= trianglar_fct( 0+0.1, 0.1+0.1 ,0 , F_sensor, 'start');
    F_M= trianglar_fct( 0.05+0.1,0.15+0.1 ,0.25+0.1 , F_sensor, 'tria');
    F_F= trianglar_fct( 0.25+0.1, 0.3+0.1 ,0 , F_sensor, 'end');
    
    % activation degree
    Ad=zeros(27,1);
    Ad(1)=min([L_N F_N R_N]);
    Ad(2)=min([L_N F_N R_M]);
    Ad(3)=min([L_N F_N R_F]);
    Ad(4)=min([L_N F_M R_N]);
    Ad(5)=min([L_N F_M R_M]);
    Ad(6)=min([L_N F_M R_F]);
    Ad(7)=min([L_N F_F R_N]);
    Ad(8)=min([L_N F_F R_M]);
    Ad(9)=min([L_N F_F R_F]);

    Ad(10)=min([L_M F_N R_N]);
    Ad(11)=min([L_M F_N R_M]);
    Ad(12)=min([L_M F_N R_F]);
    Ad(13)=min([L_M F_M R_N]);
    Ad(14)=min([L_M F_M R_M]);
    Ad(15)=min([L_M F_M R_F]);
    Ad(16)=min([L_M F_F R_N]);
    Ad(17)=min([L_M F_F R_M]);
    Ad(18)=min([L_M F_F R_F]);

    Ad(19)=min([L_F F_N R_N]);
    Ad(20)=min([L_F F_N R_M]);
    Ad(21)=min([L_F F_N R_F]);
    Ad(22)=min([L_F F_M R_N]);
    Ad(23)=min([L_F F_M R_M]);
    Ad(24)=min([L_F F_M R_F]);
    Ad(25)=min([L_F F_F R_N]);
    Ad(26)=min([L_F F_F R_M]);
    Ad(27)=min([L_F F_F R_F]);
    
    A=Ad(:);


end