%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ABC����㷨
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;close all;clc

for name=1:1

SetParams;%���ò���
fprintf('���ݶ�ȡ���\n');

%/*ABC�㷨��������*/
NP=500;%���۷�ĸ�����۲��ĸ�������Դ���������
maxCycle=1500; %�㷨����������
objfun='p_2_2_1'; %Ŀ�꺯��
ub=[1 1]; %������ȡֵ����[x1,x2,������]
lb=[0 0];%������ȡֵ����[x1,x2,������]
model=0;%ģʽ���ã�0����ʵ���滮��1���������滮
u=1;%���������������ӣ�ȡֵԽС������Խ����ȡֵΪ(0,1]
du=200;%�����ݶ�
%/*ABC�㷨��������*/

FoodNumber=NP/2; %ʳ������
D=size(ub,2); %��������
limit=NP*D;
runtime=1;%�㷨���д���
GlobalMins=zeros(1,runtime);

for r=1:runtime   
Range=ub-lb;
Lower=lb;
Foods = rand(FoodNumber,D);%rand����FoodNumber*D��С�ľ���Ԫ��Ϊ0��1
for i=1:D
    if model==1
    Foods(:,i) = round(Foods(:,i) .* Range(i) + Lower(i));
    else
    Foods(:,i) = Foods(:,i) .* Range(i) + Lower(i);
    end
end

ObjVal=feval(objfun,Foods);%feval��������ָ��������ĳ��ĺ���ֵ
Fitness=calculateFitness(ObjVal);

trial=zeros(1,FoodNumber);%��ʼ��ÿ��ʳ���trialΪ0

%/*The best food source is memorized*/
BestInd=find(ObjVal==min(ObjVal));%find�����ҵ�ObjVal�����е���Сֵ��λ��
BestInd=BestInd(end);%ȡObjVal������������Сֵ��λ��
GlobalMin=ObjVal(BestInd);%��¼��������Сֵ
GlobalParams=Foods(BestInd,:);%��¼������Сֵ��Ӧ�Ĳ�����x,y��

iter=1;
while (iter <= maxCycle)
    deta=u^(iter/du);%��������������������
%��Ӷ���Ȳ�һ����Դ��ȥ���۲��۲�
%%%%%%%%% EMPLOYED BEE PHASE %%%%%%%%%%%%%%%%%%%%%%%%
    for i=1:(FoodNumber)
        
        %/*The parameter to be changed is determined randomly*/
        Param2Change=fix(rand*D)+1;%��[1:D]�������һ������
        
        %/*A randomly chosen solution is used in producing a mutant 
        %solution of the solution i*/
        neighbour=fix(rand*FoodNumber)+1;%��������ʳ���������ѡʳ��
        %/*Randomly selected solution must be different from the solution i        
            while(neighbour==i)
                neighbour=fix(rand*FoodNumber)+1;
            end
        
       sol=Foods(i,:);
       
      if model==0
       sol(Param2Change)=Foods(i,Param2Change)+...
           (Foods(i,Param2Change)-Foods(neighbour,Param2Change))...
           *(rand-0.5)*2*deta;%ʵ���滮
       else
       sol(Param2Change)=Foods(i,Param2Change)+...
           round((Foods(i,Param2Change)-Foods(neighbour,Param2Change))...
           *(rand-0.5)*2*deta);%�����滮 
       end
       %  /*if generated parameter value is out of boundaries, it is 
       %shifted onto the boundaries*/
        ind=find(sol<lb);
        sol(ind)=lb(ind);
        ind=find(sol>ub);
        sol(ind)=ub(ind);
        
        %evaluate new solution
        ObjValSol=feval(objfun,sol);
        FitnessSol=calculateFitness(ObjValSol);
        
       % /*a greedy selection is applied between the current solution i
       %and its mutant 
       if (FitnessSol>Fitness(i)) %/*If the mutant solution is better than 
           %the current solution i, replace the solution with the mutant 
           %and reset the trial counter of solution i*/
            Foods(i,:)=sol;
            Fitness(i)=FitnessSol;
            ObjVal(i)=ObjValSol;
            trial(i)=0;
        else
            trial(i)=trial(i)+1; 
       end
    end

%%%%%%%%%%%%%%%%%%%%%%%% CalculateProbabilities %%%%%%%%%%%%%%%%%%%%%%%%%%%
prob=Fitness./sum(Fitness);
%%%%%%%%%%%%%%%%%%%%%%%% ONLOOKER BEE PHASE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i=1;
t=0;
while(t<FoodNumber)
    
    if isnan(prob(:))
        break;
    end
    
    if(rand<prob(i))
        t=t+1;
        %/*The parameter to be changed is determined randomly*/
        Param2Change=fix(rand*D)+1;
        
        %/*A randomly chosen solution is used in producing a mutant 
        %solution of the solution i*/
        neighbour=fix(rand*(FoodNumber))+1;
       
        %/*Randomly selected solution must be different from the solution i       
            while(neighbour==i)
                neighbour=fix(rand*(FoodNumber))+1;
            end
        
       sol=Foods(i,:);
       
       if model==0
       sol(Param2Change)=Foods(i,Param2Change)+...
           (Foods(i,Param2Change)-Foods(neighbour,Param2Change))...
           *(rand-0.5)*2*deta;%ʵ���滮
       else
       sol(Param2Change)=Foods(i,Param2Change)+...
           round((Foods(i,Param2Change)-Foods(neighbour,Param2Change))...
           *(rand-0.5)*2*deta);%�����滮 
       end
       
        ind=find(sol<lb);
        sol(ind)=lb(ind);
        ind=find(sol>ub);
        sol(ind)=ub(ind);
        
        %evaluate new solution
        ObjValSol=feval(objfun,sol);
        FitnessSol=calculateFitness(ObjValSol);
        
       % /*a greedy selection is applied between the current solution i and
       %its mutant*/
       if (FitnessSol>Fitness(i)) %/*If the mutant solution is better than 
       %the current solution i, replace the solution with the mutant and 
       %reset the trial counter of solution i*/
            Foods(i,:)=sol;
            Fitness(i)=FitnessSol;
            ObjVal(i)=ObjValSol;
            trial(i)=0;
        else
            trial(i)=trial(i)+1; 
       end
    end
    
    i=i+1;
     if (i==(FoodNumber)+1) %ȷ��ÿ����Դ���ٱ��۲�1��
         i=1;
     end 
end

%/*The best food source is memorized*/
         ind=find(ObjVal==min(ObjVal));
         ind=ind(end);
         if (ObjVal(ind)<GlobalMin)
         GlobalMin=ObjVal(ind);
         GlobalParams=Foods(ind,:);%������С����ֵ��Ӧ����
         end
%%%%%%%%%%%% SCOUT BEE PHASE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ind=find(trial==max(trial));
ind=ind(end);
if (trial(ind)>limit)
    Bas(ind)=0;
    
    if model==0
    sol=(ub-lb).*rand(1,D)+lb;%ʵ���滮
    else
    sol=round((ub-lb).*rand(1,D))+lb;%�����滮
    end
    
    ObjValSol=feval(objfun,sol);
    FitnessSol=calculateFitness(ObjValSol);
    Foods(ind,:)=sol;
    Fitness(ind)=FitnessSol;
    ObjVal(ind)=ObjValSol;
end

iter=iter+1; 
fprintf('����=%d GlobalMin=%g\n',iter-1,GlobalMin); 
X(iter)=iter; 
Y(iter)=GlobalMin;

end% End of ABC
GlobalMins(r)=GlobalMin;

GlobalParams %�������
end %end of runs

  figure(1);
  plot(X(2:end),Y(2:end));
  xlabel('��������');
  ylabel('����ȡֵ');
  save all;
  
  filename=['�Ǹ�����2������' num2str(name) '������������(p,q).mat'];
  save (filename,'GlobalMin','GlobalParams');
end
