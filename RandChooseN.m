function Action=RandChooseN(P,N)
% function Action=RandChooseN(P,N)
% Choose N numbers from 1 to length(P) using the
% probabilities in P. For example, if P=[0.1,0.9],
% we choose "1" 10% of the time, and "2" 90% of
% the time. Selection is done WITH replacement,
% so, for example, if N=3, we could return [2, 2, 2]
%Set up the bins
BinEdges=[0, cumsum(P(:)')];
Action=zeros(1,N);
for i=1:N
x=rand;
Counts=histc(x,BinEdges);
Action(i)=find(Counts==1);
end

end
