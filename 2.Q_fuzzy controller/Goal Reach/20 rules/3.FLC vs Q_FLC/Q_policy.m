function policy=Q_policy(Q)
policy=zeros(1,20);
%the final states are 1, 5, 9, 13, 17
for i=1:20
        [Q_max action]=max(Q(i,:));
        policy(i)=action;
end
end