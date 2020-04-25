% the reward function
% the reward is given with regards to the distance error and angle error
% beteen the robot position and the orientation 
function [Reward, Episode_end]= Reward_function2(xp, yp, thetap, xn, yn, thetan, x_d, y_d,t)
    [d_errorp, theta_errorp]= Error(xp, yp, thetap, x_d, y_d);
    [d_errorn, theta_errorn]= Error(xn, yn, thetan, x_d, y_d);
    e_theta=abs(theta_errorn)-abs(theta_errorp);
    e_theta=wrapToPi(e_theta); % always do if we use this value for comparaison
    e_d=d_errorn-d_errorp;
    Episode_end=1;
    if(e_d<=0)
        Reward=1;
    elseif (e_theta<=0) % TODO : try to keep it more simple (only one case)
        Reward=0.5;    
    else
        Reward=-1-t; % TODO : try to keep it more simple ( no t)
    end  
    
    if( d_errorn <= 0.05)
        Reward=10;
        Episode_end=0;
    end
end