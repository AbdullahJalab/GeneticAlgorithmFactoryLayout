clear,clc,close all
%creating population
popsize=50;%population size
state_cross=2;%Cross over type "0:APXCrossover";"1:MPXCrossover";2:OXCrossover
state_mutation=3;%mutation type "0:Swap";"1:insertion"
periods=5;
f=[];
mutrate=0.1; % set mutation rate
max_num_of_generations=10;
pc = 0.5; % Crossover Percentage
nc = 2*round(pc*popsize/2);  % Number of Offsprings (also Parnets)
num_of_rooms=6;
max_number_of_iteration=2;
number_of_iteration=1;
filename = 'results.xlsx';
delete(filename);
delete('best.xlsx');
craftBool=0;
while(true)
    
    j=0;%for counting the genarations
    time=[];%for xlsx file
    totalTime = 0;
    pref_fit={};
    
%%%%%%%%%%%%%%initial population%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(craftBool)
        for perr=1:popsize
            for i=1:periods
                v=randperm(num_of_rooms); 
                year{perr,i}=v;
                
            end
            years(perr,:)=craft(year(perr,:));
        end
        population=years;
      
    else
        for perr=1:popsize
            for i=1:periods
                v=randperm(num_of_rooms); 
                year{perr,i}=v;
                
            end
        end
        population=year;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    newPopulation=population;
    fit=zeros(size(newPopulation,1),1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%cross over%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while(true)
        tic;
%choosing patren and cross over   
        for i=1:round(nc/2)
            for t=1:periods%cross over for all periods 
                fa(t)=randi([1 popsize]);%choosing first parent
                ma(t)=randi([1 popsize]);%choosing seconed parent
                switch state_cross
                case 1
                    
                    [newIndivitual1{i,t},newIndivitual2{i,t}]=APXCrossover(newPopulation{fa(t),t}...
                        , newPopulation{ma(t),t});
                case 2
                    [newIndivitual1{i,t},newIndivitual2{i,t}]= MPXCrossover(newPopulation{fa(t),t},...
                        newPopulation{ma(t),t});
                case 3
                    [newIndivitual1{i,t},newIndivitual2{i,t}]= OXCrossover(newPopulation{fa(t),t},...
                        newPopulation{ma(t),t});
                case 4 
                    [newIndivitual1{i,t},newIndivitual2{i,t}]= PMXCrossover(newPopulation{fa(t),t},...
                        newPopulation{ma(t),t});
                case 5
                    [newIndivitual1{i,t},newIndivitual2{i,t}]=POSCrossover(newPopulation{fa(t),t},...
                        newPopulation{ma(t),t});
                case 6
                    [newIndivitual1{i,t},newIndivitual2{i,t}]=CXCrossover(newPopulation{fa(t),t},...
                        newPopulation{ma(t),t});
                case 7
                    [newIndivitual1{i,t},newIndivitual2{i,t}]=AEXcrossover(newPopulation{fa(t),t},...
                        newPopulation{ma(t),t});
                case 8
                    [newIndivitual1{i,t},newIndivitual2{i,t}]=ERXcrossover(newPopulation{fa(t),t},...
                        newPopulation{ma(t),t});
                end
            end 
        end
        newPopulation=[newPopulation;newIndivitual1;newIndivitual2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%mutetion%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        nmut=ceil((popsize)*num_of_rooms*mutrate); % total number of mutations
        mrow=ceil(random(1,popsize,1,nmut)); % row to mutat
        switch state_mutation
            case 0
                for ii=1:nmut
                    for p=1:periods
                        newPopulation{mrow(ii),p}= ApplySwap(newPopulation{mrow(ii),p});
                    end
                end
            case 1
                for ii=1:nmut
                    for p=1:periods
                        newPopulation{mrow(ii),p}= ApplyInsertion(newPopulation{mrow(ii),p});
                    end
                end
            case 2
                for ii=1:nmut
                    for p=1:periods
                        newPopulation{mrow(ii),p}= ApplyReversion(newPopulation{mrow(ii),p});
                    end
                end
            case 3 
                 for ii=1:nmut
                    
                    newPopulation(mrow(ii))= craft(newPopulation(mrow(ii)));
                    
                end
        end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%evaluation the generation%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for i=1:size(newPopulation,1)
            fit(i,1)=goal(newPopulation(i,:));
        end
        j=j+1;
        
        [fit,index]=sort(fit);
        pref_fit{j}=fit(1);
        newPopulation=newPopulation(index(1:popsize),:);
        plot(1:length(pref_fit),cell2mat(pref_fit),'LineWidth',2) 
        xlabel('Iterations')
        ylabel('Best cost')
        hold on
        pause(0.0000001);
       
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        timeElapsed = toc;
        time=[time;timeElapsed];
        totalTime = totalTime + timeElapsed;
        disp(['Time ' num2str(timeElapsed)]);
 %%%%%%%%%for stopping when it isn't optimize any more%%%%%%%%%
        if(j>300)
            first5=[pref_fit{end-100:end-50}];
            last5=[pref_fit{end-50:end}];
            error=abs(sum(first5)-sum(last5));
            if(error<0.1)
                sprintf(' the best sulution %d',fit(1))
                disp('sectors')
                newPopulation{1,:}
                sprintf(' the number of generations %d',j)
                GoalWithoutshifting(newPopulation(1,:));
                break
            end   
        end
%%%%%%%%%%%%%for stoping when we reach to max number of generations%%%%%
        if(j>=max_num_of_generations)
            sprintf(' the best sulution %d',fit(1))
            disp('sectors')
            newPopulation{1,:}
            
            sprintf(' the number of generations %d',j)
            GoalWithoutshifting(newPopulation(1,:));
            break
        end
    end
    disp(['Total Time ' num2str(totalTime)]);
    disp(['Total Time (minutes) ' num2str(totalTime/60)]);
%%%%%%%%writing result to xlsx%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    filename = 'results.xlsx';
    for temp=1:periods
        f=[f;newPopulation{1,temp}];
    end
    tble=table(f','variableNames',{'Best_order_period'});
    writetable(tble,filename,'Sheet',number_of_iteration)
    tble=table(time,'variableNames',{'Time'});
    writetable(tble,filename,'Sheet',number_of_iteration,'Range','F1')
    tble=table(totalTime,'variableNames',{'totalTime'});
    writetable(tble,filename,'Sheet',number_of_iteration,'Range','G1')
    tble=table(j,'variableNames',{'number_of_generation'});
    writetable(tble,filename,'Sheet',number_of_iteration,'Range','H1')
    tble=table(pc ,'variableNames',{'crossover_Percentage'});
    writetable(tble,filename,'Sheet',number_of_iteration,'Range','I1')
    tble=table(mutrate ,'variableNames',{'mutation_rate'});
    writetable(tble,filename,'Sheet',number_of_iteration,'Range','J1')
    tble=table(popsize ,'variableNames',{'population_size'});
    writetable(tble,filename,'Sheet',number_of_iteration,'Range','H1')
    f=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    number_of_iteration=number_of_iteration+1;
    if( number_of_iteration>=( max_number_of_iteration+1))
        
        break
    end
    %pause(0.01);
end
tbl=table(cell2mat(pref_fit)' ,'variableNames',{'Best_cost'});
writetable(tbl,'best.xlsx','Sheet',state_cross,'Range','A1')
open(filename)
open('best.xlsx')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%