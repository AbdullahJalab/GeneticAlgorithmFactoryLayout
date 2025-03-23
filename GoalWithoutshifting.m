function GoalWithoutshifting(cromosome)
load('flow_per.mat')
load('costed.mat')
load('shifting_costs.mat')
pers=length(cromosome);
c=0;
for i=1:pers
d{i}=distance(cromosome{i});
t=flow_per{i}.*d{i}.*costed;
c(i)=sum(t(:));
disp(sprintf(' the cost of period%d = %d \n',i,c(i)))
end
cost_shifting=0;
y=0;
for j=1:pers-1
    
    temp=cromosome{j+1};
    index=find(cromosome{j}~=cromosome{j+1});
    for i=1:length(index)
        cost_shifting=cost_shifting+shifting_costs(temp(index(i)));
    end
    y=[y,cost_shifting];
    cost_shifting=0;
    disp(sprintf('the Relayout costs of period%d = %d \n',j,y(j)))
end
disp(sprintf('the Relayout costs of period%d = %d \n',pers,y(end)))
cost_shifting=sum(y);
c=c+cost_shifting;    

end
   