% Obstacle Avoidance 
% L_sensor = {N, M, F}
% R_sensor = {N, M, F}
% F_sensor = {N, M, F}

% L = {NH, N, P, HP}
% R = {NH, N, P, HP}


function [Lw, Rw]= obstacle_avoidance_FLC_corr(L_sensor, R_sensor, F_sensor)

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

% rules activation
    % L = {NH, N, P, HP}
    A_L_NH= max([Ad(1) Ad(4) Ad(7) Ad(10) Ad(11) Ad(14) Ad(19) Ad(20)]);
    A_L_N=  max([Ad(13) Ad(16) Ad(22) Ad(23) Ad(24) Ad(25)]);
    A_L_P= max([Ad(8) Ad(9) Ad(17) Ad(26) Ad(27)]);
    A_L_HP= max([Ad(2) Ad(3) Ad(5) Ad(6) Ad(12) Ad(15) Ad(18) Ad(21)]);

    % R = {NH, N, P, HP}
    A_R_NH= max([Ad(1) Ad(2) Ad(3) Ad(4) Ad(7) Ad(12) Ad(14) Ad(21)]); 
    A_R_N = max([Ad(5) Ad(6) Ad(8) Ad(9) Ad(15)]); 
    A_R_P = max([ Ad(17) Ad(18) Ad(23) Ad(24) Ad(27)]); 
    A_R_HP = max([Ad(10) Ad(11) Ad(13) Ad(16) Ad(19) Ad(20) Ad(22) Ad(25) Ad(26)]);

% outputs memberships functions  
    O_L_NH= -2; %-2; % -1.2
    O_L_N=  -0.6; %-0.8;  % -0.4
    O_L_P= 0.6 %0.8;   %  0.4
    O_L_HP= 2;  %  1.2
 
    O_R_NH= O_L_NH;
    O_R_N= O_L_N;
    O_R_P= O_L_P;
    O_R_HP= O_L_HP;


% Méthode du centre de gravité
%Lw=(O_L_NH*A_L_NH + O_L_N*A_L_N + O_L_P*A_L_P + O_L_HP*A_L_HP )/(A_L_NH + A_L_N + A_L_P + A_L_HP );
%Rw=(O_R_NH*A_R_NH + O_R_N*A_R_N + O_R_P*A_R_P + O_R_HP*A_R_HP)/(A_R_NH + A_R_N + A_R_P + A_R_HP );

% Méthode de la moyenne des maxima
Lw=(O_L_NH*A_L_NH + O_L_N*A_L_N + O_L_P*A_L_P + O_L_HP*A_L_HP )/3;
Rw=(O_R_NH*A_R_NH + O_R_N*A_R_N + O_R_P*A_R_P + O_R_HP*A_R_HP)/3;

end