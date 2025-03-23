% Cite As
% Yro (2022). Ordered Crossover Operator for Permutations-based Problems (https://www.mathworks.com/matlabcentral/fileexchange/93715-ordered-crossover-operator-for-permutations-based-problems), MATLAB Central File Exchange. Retrieved July 30, 2022.
function [y1, y2] = OXCrossover(x1,x2)
% SELECT TWO CROSSPOINTS
nVar = numel(x1);
cc = randsample(nVar-1, 2);
pos1 = min(cc);
pos2 = max(cc);
% POSITIONS FROM THE SAME PARENT
p1 = 1:pos1-1;
p2 = pos2 + 1:length(x1);
p = [p1 p2];

% ARRANGEMENT FOR THE CHILDREN
y1 = zeros(1, length(x1));
y2 = zeros(1, length(x2));

% VALUES BETWEEN THE TWO CROSS POINTS
y1(pos1:pos2) = x1(pos1:pos2);
y2(pos1:pos2) = x2(pos1:pos2);

% Populate the first child from the second crosspoint without it belonging to the other parent
% Order from the second point to the same
or1 = x1;
or2 = x2;

%% To generate the first child I take the order of the second parent and the string between c1 and c2 of the first parent

for i = 1:length(or1)
    m(i,:) = ~ismember(or2(i), y1(pos1:pos2));
end
or22 = or2(m);
for j = 1:length(p)
    y1(p(j)) = or22(j);
end

%% To generate the second child I take the order of the first parent and the string between c1 and c2 of the second parent
for i = 1:length(or2)
    m(i,:) = ~ismember(or1(i), y2(pos1:pos2));
end
or11 = or1(m);
for j = 1:length(p)
    y2(p(j)) = or11(j);
end

end

