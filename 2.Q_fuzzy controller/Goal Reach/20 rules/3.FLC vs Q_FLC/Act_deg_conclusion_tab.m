% return the activation degrees of the outputs 
% the encountered problem is that the conclusions changes over iteration
% so we need a function to associate each rul with each conclusion every
% time
function [A_L_Z, A_L_M, A_L_H, A_R_Z, A_R_M, A_R_H]= Act_deg_conclusion_tab(Ad, Actions)

NStates=20;
A=Ad(:); 

Tab=zeros(NStates,2); 
% state 1 ( row order )  :  A(1)   actions(1)  
for i=1:20
    Tab(i,1)=A(i);
    Tab(i,2)=Actions(i);
end

% the conclusion L_Z exists the the actions 1 2 and 3
vec=[];
for i=1:NStates
     vec=[vec Tab(i,1)*(Tab(i,2)==1 | Tab(i,2)==2 | Tab(i,2)==3)];
end
A_L_Z=max(vec);

% the conclusion L_M exists the the actions 4 5 and 6
vec=[];
for i=1:NStates
    vec=[vec Tab(i,1)*(Tab(i,2)==4 | Tab(i,2)==5 | Tab(i,2)==6)];
end
A_L_M=max(vec);

% the conclusion L_H exists the the actions 7 8 and 9
vec=[];
for i=1:NStates
    vec=[vec Tab(i,1)*(Tab(i,2)==7 | Tab(i,2)==8 | Tab(i,2)==9)];   
end
A_L_H=max(vec);

% the conclusion R_Z exists the the actions 1 4 and 7
vec=[];
for i=1:NStates
    vec=[vec Tab(i,1)*(Tab(i,2)==1 | Tab(i,2)==4 | Tab(i,2)==7)];
end
A_R_Z=max(vec);

% the conclusion R_M exists the the actions 2 5 and 8
vec=[];
for i=1:NStates
    vec=[vec Tab(i,1)*(Tab(i,2)==2 | Tab(i,2)==5 | Tab(i,2)==8)];
end
A_R_M=max(vec);

% the conclusion R_H exists the the actions 3 6 and 9
vec=[];
for i=1:NStates
    vec=[vec Tab(i,1)*(Tab(i,2)==3 | Tab(i,2)==6 | Tab(i,2)==9)];
end
A_R_H=max(vec);

end