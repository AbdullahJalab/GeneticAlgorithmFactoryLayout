% coded and tested by Rami Herh on 20 Sep 2022
function [y1,y2] = APXCrossover(x1,x2)
nVar = numel(x1);
y = [];
px = [x1;x2];
o = 1;
while (o <= 2)
    i = 1;
    j = 1;
    k = 1;
    while(i <= nVar)
        if (~ismember(px(1,j),y))
            y(i) = px(1,j);
            i = i + 1;
        end
        j = j + 1;
        if (~ismember(px(end,k),y))
            y(i) = px(end,k);
            i = i + 1;
        end
        k = k + 1;
    end
    px = flip(px);
    f(o,:) = y;
    y = [];
    o = o + 1;
end
y1 = f(1,:);
y2 = f(2,:);
end
