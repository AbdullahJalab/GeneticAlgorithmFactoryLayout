%%coded by Eng.Abdullah Jalab in 1/22/2023 
function [y1,y2]=AEXcrossover(x1,x2)
not_visted1=1:length(x1);
y1(1)=x1(1);
y1(2)=x1(2);
ind1=find(not_visted1==y1(1));
not_visted1(ind1)=[];
ind1=find(not_visted1==y1(2));
not_visted1(ind1)=[];
%%
not_visted2=1:length(x2);
y2(1)=x2(1);
y2(2)=x2(2);
ind2=find(not_visted2==y2(1));
not_visted2(ind2)=[];
ind2=find(not_visted2==y2(2));
not_visted2(ind2)=[];
%%2
for i=2:2:length(x1)-2
   indx1=find(x2==y1(i));
   if(ismember(x2(examIndex(indx1+1,length(x1))),not_visted1))
       y1(i+1)=x2(examIndex(indx1+1,length(x2)));
       idx1=find(not_visted1==x2(examIndex(indx1+1,length(x2))));
       not_visted1(idx1)=[];

   elseif(~ismember(x2(examIndex(indx1+1,length(x1))),not_visted1))

       id=randi([1,length(not_visted1)]);
       a=not_visted1(id);
       y1(i+1)=a;
       not_visted1(id)=[];
   end
   %%%%y2
   indx2=find(x1==y2(i));
   if(ismember(x1(examIndex(indx2+1,length(x2))),not_visted2))
       y2(i+1)=x1(examIndex(indx2+1,length(x2)));
       idx2=find(not_visted2==x1(examIndex(indx2+1,length(x2))));
       not_visted2(idx2)=[];

   elseif(~ismember(x1(examIndex(indx2+1,length(x2))),not_visted2))
    
       id=randi([1,length(not_visted2)]);
       a=not_visted2(id);
       y2(i+1)=a;
       not_visted2(id)=[];
   end
%%%%%%%%%y1
   indx1=find(x1==y1(i+1));
   if(ismember(x1(examIndex(indx1+1,length(x2))),not_visted1))
       y1(i+2)=x1(examIndex(indx1+1,length(x2)));
       idx1=find(not_visted1==x1(examIndex(indx1+1,length(x2))));
       not_visted1(idx1)=[];
       
       

   elseif(~ismember(x1(examIndex(indx1+1,length(x2))),not_visted1))
       y1(i+2)=x1(examIndex(indx1+1,length(x2)));
       id=randi([1,length(not_visted1)]);
       a=not_visted1(id);
       y1(i+2)=a;
       not_visted1(id)=[];
   end
   %%y2
   indx2=find(x2==y2(i+1));
   if(ismember(x2(examIndex(indx2+1,length(x2))),not_visted2))
       y2(i+2)=x2(examIndex(indx2+1,length(x2)));
       idx2=find(not_visted2==x2(examIndex(indx2+1,length(x2))));
       not_visted2(idx2)=[];
   elseif(~ismember(x2(examIndex(indx2+1,length(x2))),not_visted2))
       id=randi([1,length(not_visted2)]);
       a=not_visted2(id);
       y2(i+2)=a;
       not_visted2(id)=[];
   end
   
   
end
end