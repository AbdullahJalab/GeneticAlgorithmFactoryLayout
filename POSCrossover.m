% coded and tested by Rami Herh on 19 Sep 2022
function [y1,y2] = POSCrossover(x1,x2)

nVar = numel(x1);

p = randperm(nVar,3);
p = sort(p,'ascend');

v = 1 : nVar;
v = v(~ismember(v,p));

y1(p) = x2(p);
y2(p) = x1(p);

for i = v
    for j = 1 : nVar
        if(~ismember(x1(j),y1))
            y1(i) = x1(j);
            break;
        end
    end
end

for i = v
    for k = 1 : nVar
        if(~ismember(x2(k),y2))
            y2(i) = x2(k);
            break;
        end
    end
end

end
