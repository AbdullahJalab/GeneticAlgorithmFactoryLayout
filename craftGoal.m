function c=craftGoal(g,k)
load('flow_per.mat')
load('costed.mat')
load('shifting_costs.mat')
d=distance(g);
t=flow_per{k}.*d.*costed;
c=sum(t(:));   
end
   