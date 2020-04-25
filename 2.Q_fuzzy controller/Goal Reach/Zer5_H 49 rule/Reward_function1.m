% the reward function
% the reward is given with regards to the distance error and angle error
% beteen the robot position and the orientation 
function [Reward, Episode_end]= Reward_function1(xp, yp, thetap, xn, yn, thetan, x_d, y_d)
    [d_errorp, theta_errorp]= Error(xp, yp, thetap, x_d, y_d);
    [d_errorn, theta_errorn]= Error(xn, yn, thetan, x_d, y_d);
    e_theta=abs(theta_errorn)-abs(theta_errorp);
    e_d=d_errorn-d_errorp;
    Episode_end=1;
    Reward=-1;
    if(e_d<=0 || e_theta<=0)
        Reward= Reward+2;
    else
        Reward= Reward-2;
    end
    
    
    if( d_errorn <= 0.03)
        Reward=10;
        Episode_end=0;
    end
end