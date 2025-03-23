function t=exchangesVetor(x)
c=[];
y=x;
for i=1:length(x)
    a=x(i);
    for j=i+1:length(x)
       b=x(j);
       y(j)=a;
       y(i)=b;
       c=[c;y];
       y=x;
       
    end
end
t=[x;c];
end
