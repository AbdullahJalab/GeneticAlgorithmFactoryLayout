function dist=distance(sec)

cro={[1,2],[2,2],[3,2],[1,1],[2,1],[3,1]}; 
 for j=1:length(cro)
     for i=1:length(cro)
         dist(i,j)=sum(abs(cro{find(sec==i)}-cro{find(sec==j)}));
     end
 end
end