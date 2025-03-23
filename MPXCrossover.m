% coded and tested by Rami Herh on 19 Sep 2022
function [y1,y2] = MPXCrossover(x1,x2)

nVar = numel(x1);
lc = randsample(nVar,2);

s1 = min(lc);
s2 = max(lc);
c  = 1 + range(lc);

y1(1:c) = x1(s1:s2);
y2(1:c) = x2(s1:s2);

v1 = [];
v2 = [];

for i = 1 : nVar
    if(~ismember(x2(i),y1))
        v1 = [v1,x2(i)];
    end
    if(~ismember(x1(i),y2))
        v2 = [v2,x1(i)];
    end
end

y1 = [y1,v1];
y2 = [y2,v2];

end
