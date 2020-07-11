%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����ģ�Ͳ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global...
Flow City Now LineData...
People CoePeople Need Line Accept SpeedTec...
AvGdp CoeAvGdp Uincome CoeUincome Rincome...
CoeRincome Sincome Sage CoeIncome CoeAge...
S CoeNeed CoeLine AgeStru Distance CoeT

%������ʼ��
City=20;
Now=2017;%�������ݶ�Ӧ��ʱ�� 
X=1;%��׼�ɱ�
LineData=[400/8 200 32 X;600/8 100 48 1.25*X;800/8 80 64 1.5*X];%��ѡ����صĲ���
Flow=10000*xlsread('�㶫2012-2017��������������.xlsx','b2:b7')+...%��λ/GB
     10000*xlsread('�㶫2012-2017��������������.xlsx','d2:d7');
People=10000*xlsread('�㶫2012-2017�������˿�(��������).xls','b2:g22');%��λ/��
Distance=xlsread('�㶫�����е����ݵ�ʵ�ʾ���͹滮����.xlsx','b2:b21');%��λ/ǧ��
AvGdp=xlsread('�㶫2012-2017����ȫ������˾�����(��������).xls','b2:g22');%ÿ������ƽ��GDP����λ/Ԫ
Uincome=xlsread('�㶫2012-2017���г�������˾�����(��������).xls','b2:g22');%ÿ�����г���ƽ������,��λ/Ԫ
Rincome=xlsread('�㶫2012-2017����ũ������˾�����(��������).xls','b2:g22');%ÿ������ũ��ƽ�����룬��λ/Ԫ
AgeStru=xlsread('�㶫�������˿ڽṹ����.xlsx','b2:d22');%�������˿ڽṹ����

CoePeople=xlsread('�㶫2012-2017�������˿�(��������).xls','h2:h22');%�˿�������
CoeAvGdp=xlsread('�㶫2012-2017����ȫ������˾�����(��������).xls','h2:h22');%������ƽ��GDP����ϵ��
CoeUincome=xlsread('�㶫2012-2017���г�������˾�����(��������).xls','h2:h22');%�����г���ƽ����������ϵ��
CoeRincome=xlsread('�㶫2012-2017����ũ������˾�����(��������).xls','h2:h22');%ũ��ƽ����������ϵ��

CoeIncome=2.7746*10^-12;%��������ϵ��
CoeAge=35.8625;%��������ϵ��
SpeedTec=219.2836;%��������ϵ��
CoeT=0.0343;%ָ������ϵ��

CoeNeed=1;%������ת�����ֵϵ��
CoeLine=1;%���߳ɱ�ת���߼�ֵϵ��

Sincome=AvGdp./(Uincome-Rincome);%ÿ�����е���������(����ƽ��GDP/������ƽ������-ũ��ƽ�����룩)
Sage=(1*AgeStru(:,1)+3*AgeStru(:,2)+1*AgeStru(:,3))./5;%ÿ�����е���������
Sage=repmat(Sage,1,6);%��Sage��ֱ������1�Σ�ˮƽ������6��
S=CoeIncome.*Sincome+CoeAge.*Sage;%ÿ�����е��ۺ����ۣ���������ϵ��*��������+��������ϵ��*�������ۣ�
Accept=-1./(S+1)+1; %ÿ�����пƼ����ܶ�,ȡֵ��Χ[0,1]
for i=1:size(S,2)
    S(:,i)=S(:,i).^(CoeT*i);
end
Need=S.*SpeedTec.*Accept.*People;%ÿ�����е�����������
Line=zeros(size(Need));%ÿ�����еĲ��߳ɱ�



