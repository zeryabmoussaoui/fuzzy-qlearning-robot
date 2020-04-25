% Inspired by :
% [1] pooyanjamshidi Fuzzy QL pseudocode
% {2] Reinforcement Distribution in Fuzzy Q-learning
close all
clear;
clc;

%% Robot parameters
R = 0.035; L = 0.28;


%% Fuzzy Q learning Algorithm

% Action management 

R_Z=0;
R_M=1.5;
R_H=4;
  
L_Z= R_Z;
L_M= R_M;
L_H= R_H;

Actions=[R_Z L_Z ; R_Z L_M ; R_Z L_H ; R_M L_Z; R_M L_M ; R_M L_H ; R_H L_Z ; R_H L_M ; R_H L_H]; % each row corresponds to the action index
R_Actions=Actions(:,1);
L_Actions=Actions(:,2);

%%%
NRules=20;
%%%
selected_WR=zeros(NRules,1); % selected actions from each rules in an iteration
selected_WL=zeros(NRules,1);            

% Q learning coeff
alpha0=1;             % learning rate
gamma=0.7;              % discount factor
epsilon0=1;            % Epsilon greedy coeffi ( exploration rate )
decr = 0.998; 		% decrease factor  

% Actions and states
NConclusions=9; % 3*3 actions for each wheel 
NRules=20; % 4*5 MFs combinaison

% 1-Initialisation of q table 	
q = zeros(NRules, NConclusions);

% conclusions
Conclusions=zeros(NRules,1);

% Loop
NEpisodes=8000; 

%Full exploitation params (Uncomment if necessary)
NEpisodes=1;
alpha0=0; % no learning
epsilon0=0;
load('qtable4000'); % also comment q=zeros(,) in step1


x_d=1; y_d=1;

% simulation parameters
t_final=150;

vect_cumReward=[];
for Episode = 1 : NEpisodes
        t=0;
		vect_t=[];
		vect_x=[];
		vect_y=[];
		vect_theta=[];
		
		cumReward=0;      % cumulative Rewerd for each episode

        % starting position      
        x_init=rand*2; y_init=rand*2 ; theta_init=0; % Begin at a random place between [0 2] to avoid overfitting
        xp=x_init ;yp=y_init; thetap=theta_init;

        % desired position
        

        Episode_end=1; % 0 if the end of episode
        sim_delta = 0.1; % sample Time
        % Initialise Q learning params
		alphaI=alpha0;
        epsilonI=epsilon0;
        while ( (Episode_end~=0) && (t < t_final) )     % loop until find goal state
            alphaI=alphaI*decr; % decrease learning rate
 	        epsilonI=epsilonI*decr;
	        t=t+sim_delta;
            cumReward=0;
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
	        	
        Rules_deg0 = Rules_act_deg(xp, yp, thetap, x_d, y_d); % rule activation "alpha")
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
           
            %% 6- observe the reinforcement signal r(t+1) and compute the value for new state
            [Reward, Episode_end]= Reward_function1(xp, yp, thetap, xn, yn, thetan, x_d, y_d);
            
            Rules_deg1= Rules_act_deg(xn, yn, thetan, x_d, y_d);
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
			
			% Log trajectory
			vect_t=[vect_t t];
			vect_x=[vect_x xp];
			vect_y=[vect_y yp];
			vect_theta=[vect_theta thetap];  
                        
			
        end
        fprintf('Episode %i termin�. Le robot a fait %i It�rations. La r�comence cumul�e est %i.\n', Episode, t, cumReward);
        
        if mod(Episode,500)==0
            save(strcat('qtable',int2str(Episode)),'q') 
        end
end

%save('qtable','q');
 
figure(1) 
subplot(3,1,1); plot(vect_t,vect_x,'r'); title('position x'); xlabel('x(m)'); ylabel('t');
subplot(3,1,2); plot(vect_t,vect_y,'r'); title('positon y'); xlabel('y(m)'); ylabel('t');
subplot(3,1,3); plot(vect_t,vect_theta,'r'); title('angle theta'); xlabel('theta(rad)'); ylabel('t');

figure(2)
plot(vect_x,vect_y); title('robot position'); xlabel('x(m)'); ylabel('y(m)'); 
