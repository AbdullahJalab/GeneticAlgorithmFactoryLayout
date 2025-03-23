function y=craft(x)%x is cell
for i=1:length(x)
    a{i}=exchangesVetor(x{i});
    b=a{i};
    for j=1:size(b,1)
        fit(j)=craftGoal(b(j,:),i);
    end
    [fit,index]=sort(fit');
    y{i}=b(index(1),:);
end
end