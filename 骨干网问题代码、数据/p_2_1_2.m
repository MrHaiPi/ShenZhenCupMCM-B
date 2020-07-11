%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������Ԥ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SetParams;%���ó�ʼ������

Future=2028;%ģ��Ԥ��ʱ��
dt=Future-Now;  
t0=size(People,2);

%��������
AvGdp=[AvGdp zeros(21,dt-t0+1)];
Accept=[Accept zeros(21,dt-t0+1)];
Need=[Need zeros(21,dt-t0+1)];
Line=[Line zeros(21,dt-t0+1)];
People=[People zeros(21,dt-t0+1)];
Rincome=[Rincome zeros(21,dt-t0+1)];
S=[S zeros(21,dt-t0+1)];
Sage=[Sage zeros(21,dt-t0+1)];
Sincome=[Sincome zeros(21,dt-t0+1)];
Uincome=[Uincome zeros(21,dt-t0+1)];

for i=t0+1:dt+t0
    
    %��ز���Ԥ��
    AvGdp(:,i)=AvGdp(:,i-1).*(1+CoeAvGdp);
    Uincome(:,i)=Uincome(:,i-1).*(1+CoeUincome);
    Rincome(:,i)=Rincome(:,i-1).*(1+CoeRincome);
    People(:,i)=People(:,i-1).*(1+CoePeople);
    
    %��ز����ټ���
    Sincome(:,i)=AvGdp(:,i)./(Uincome(:,i)-Rincome(:,i)); 
    Sage(:,i)=(1*AgeStru(:,1)+3*AgeStru(:,2)+1*AgeStru(:,3))./5;
    S(:,i)=CoeIncome.*Sincome(:,i)+CoeAge.*Sage(:,i); 
    Accept(:,i)=-1./(S(:,i)+1)+1;  
    Need(:,i)=S(:,i).^(CoeT*i).*SpeedTec.*Accept(:,i).*People(:,i);
    
    fprintf('%d������е�Ԥ���������������\n',i+Now-t0);

end

save ('�Ǹ�����1�㶫2012-2028�����������.mat','Need');


   