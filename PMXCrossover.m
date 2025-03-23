function [y1,y2] = PMXCrossover(x1,x2)

nVar = numel(x1);
cc = randsample(nVar-1, 2);
pos1 = min(cc);
pos2 = max(cc);


ss1 = x1(pos1:pos2);
ss2 = x2(pos1:pos2);

y1 = x2;
y2 = x1;

for i = [1:pos1-1 pos2+1:nVar]
    
    y1(i) = x1(i);
    j = find(y1(i) == ss2);
    
    while ~isempty(j)
        y1(i) = ss1(j);
        j = find(y1(i) == ss2);
    end
    
    y2(i) = x2(i);
    j = find(y2(i) == ss1);
    while ~isempty(j)
        y2(i) = ss2(j);
        j = find(y2(i) == ss1);
    end
end