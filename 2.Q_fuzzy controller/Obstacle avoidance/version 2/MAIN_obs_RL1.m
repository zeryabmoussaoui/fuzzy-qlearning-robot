close all
clear;
clc;

%% Robot parameters
R = 0.035; L = 0.28;
min_range=0.1; max_range=0.4;

%% Fuzzy Q learning Algorithm
% Rules and Conclusions
NConclusions=11; 
NRules=27; 

% Action management 

R_NH=-2;
R_N=-0.8;
R_P=0.8;
R_PH=2;

L_NH=R_NH;
L_N=R_N;
L_P=R_P;
L_PH=R_PH;

Actions=[L_NH R_P; L_NH R_PH; L_N R_P;  L_N R_PH; L_P R_NH;  L_P R_N; L_P R_P; L_P R_PH; L_PH R_NH; L_PH R_N; L_PH R_P]; % each row corresponds to the action index
R_Actions=Actions(:,2);
L_Actions=Actions(:,1);

selected_WR=zeros(NRules,1); % selected actions from each rules in an iteration
selected_WL=zeros(NRules,1);       

%% Fuzzy Q learning Algorithm

% Q learning coeff
alpha0=1;             % learning rate
gamma=0.7;              % discount factor
epsilon0=1;            % Epsilon greedy coeffi ( exploration rate )
decr = 0.998; 		% decrease factor  

% 1-Initialisation of q table 	
q = zeros(NRules, NConclusions);

% conclusions
Conclusions=zeros(NRules,1);

% Loop
NEpisodes=2000; 

%Full exploitation params (Uncomment if necessary)
NEpisodes=1;
alpha0=0; % no learning
epsilon0=0;
load('qtable1000'); % also comment q=zeros(,) in step1

% simulation parameters
t_final=150;

% the env
[ wall_u wall_d] = environment_type2();


for Episode = 1 : NEpisodes
        t=0;
		vect_t=[];
		vect_x=[];
		vect_y=[];
		vect_theta=[];
        
        x_init=0; y_init=3.6; theta_init=65*pi/180;
        xp=x_init ;yp=y_init; thetap=theta_init;
        
        cumReward=0;      % cumulative Rewerd for each episode
        
        Episode_end=1; % 0 if the end of episode
        sim_delta = 0.1; % sample Time
        
        % Initialise Q learning params
		alphaI=alpha0;
        epsilonI=epsilon0;
        
       while ( (Episode_end~=0) && (t < t_final) )     % loop until find goal state
       t=t+sim_delta;
       [L_sensor_p, R_sensor_p, F_sensor_p, detect] = sensor_value_obs(xp, yp, thetap,min_range,max_range, wall_u, wall_d);
        
       if (detect == 0)
           W_Lc=3; W_Rc=3;
           [ w_l,w_r] = Diff_Robot_Model(W_Lc, W_Rc, sim_delta);           
           [xn,yn,thetan]= Odometry(w_l, w_r, sim_delta,xp,yp, thetap,[R L]);
           xp=xn; yp=yn; thetap=thetan;
       
       
       else
            alphaI=alphaI*decr; % decrease learning rate
            epsilonI=epsilonI*decr;

            

            %% 2 select an action for each fired rule
            for rule=1:NRules
                if rand > epsilonI   % exploitation
                    [QValue, Curr_Conclusion] = max(q(rule,:));   % the q table is in order

                else   % exploration
                    Curr_Conclusion=round((NConclusions-1)*rand+1);
                end
                Conclusions(rule)=Curr_Conclusion;     % update the conclusion of each rule
            end

            %% 3-calculate the control action by the fuzzy controller 

            Rules_deg0 = Rules_act_deg_obs(L_sensor_p, R_sensor_p, F_sensor_p); % rule activation "alpha")
            W_Rules_deg0 = Rules_deg0/sum(Rules_deg0);  % weighted rule "psi" ( seen from : [2] "Action selection")

            selected_WR=R_Actions(Conclusions);     
            selected_WL=L_Actions(Conclusions);          

            W_Rc= selected_WR'*W_Rules_deg0; % weigthed sum using scalar product
            W_Lc= selected_WL'*W_Rules_deg0; 


            %% 4-approxiame the Q function from the q-values and the firing levels of the rule

            Q0=0;
            for i=1:NRules
                Q0=Q0+W_Rules_deg0(i)*q(i,Conclusions(i)); % seen from [2] fig3
            end

            cumReward=cumReward+Q0;
            %% 5-take action a and let the system goes to the next state  

            [ w_l,w_r] = Diff_Robot_Model(W_Lc, W_Rc, sim_delta);           
            [xn,yn,thetan]= Odometry(w_l, w_r, sim_delta,xp,yp, thetap,[R L]);
            [L_sensor_n, R_sensor_n, F_sensor_n, detect] = sensor_value_obs(xn, yn, thetan,min_range,max_range, wall_u, wall_d);

            %% 6- observe the reinforcement signal r(t+1) and compute the value for new state

            [Reward, Episode_end]= Reward_function_obs(xn,yn,L_sensor_n, R_sensor_n, F_sensor_n,L_sensor_p, R_sensor_p, F_sensor_p, wall_u, wall_d);

            Rules_deg1= Rules_act_deg_obs(L_sensor_n, R_sensor_n, F_sensor_n);
            W_Rules_deg1 = Rules_deg1/sum(Rules_deg1);
            V=0;
            for i=1:NRules
               V=V+(W_Rules_deg1(i)*max(q(i,:)));            
            end

            %% 7- calculate the error signal
            delta_Q= Reward + gamma*V-Q0;

            %% 8- update q-values
            for i=1:NRules
               q(i,Conclusions(i))=q(i,Conclusions(i))+ alphaI*delta_Q*W_Rules_deg0(i);
            end

            xp=xn ;yp=yn; thetap=thetan;
       end
			% Log trajectory
			vect_t=[vect_t t];
			vect_x=[vect_x xp];
			vect_y=[vect_y yp];
			vect_theta=[vect_theta thetap];  
                        
			
        end
        fprintf('Episode %i terminé. Le robot a fait %i Itérations. La récopmence acumulée est %i.\n', Episode, t, cumReward);
        
        if mod(Episode,500)==0
            save(strcat('qtable',int2str(Episode)),'q') ;
        end
end

save('qtable','q');

draw_PFE2(vect_x, vect_y,vect_theta,vect_t,x_init,y_init);7
%visualization_vect(vect_x, vect_y,vect_theta,vect_t,min_range,max_range, wall_u, wall_d)