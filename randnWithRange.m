function x=randnWithRange(xmin,xmax,center,n)

%Generating a standard normal distribution
temp = normrnd(center,3,1,n);
%Rescaling the range
x=xmin+(xmax-xmin)*((temp-min(temp))/(max(temp)-min(temp)));

end