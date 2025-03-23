function c=each_perid(cromosome)
load('flow_per.mat')
load('costed.mat')
load('shifting_costs.mat')
pers=length(cromosome);
c=0;
for i=1:pers
d{i}=distance(cromosome{i});
t=flow_per{i}.*d{i}.*costed;
c(i)=sum(t(:));
end
end
