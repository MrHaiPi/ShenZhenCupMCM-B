%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%������ϣ�CoeIncome��CoeAge��SpeedTec��CoeT��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ObjVal = p_2_1_1(Chrom)

global...
Flow People Need Accept SpeedTec...
S Sincome Sage CoeIncome CoeAge CoeT
    
ObjVal=zeros(size(Chrom,1),1);
for i=1:size(Chrom,1)
   
    CoeIncome=Chrom(i,1);
    CoeAge=Chrom(i,2);
    SpeedTec=Chrom(i,3);
    CoeT=Chrom(i,4);
    
    S=CoeIncome.*Sincome+CoeAge.*Sage;%ÿ�����е��ۺ����ۣ���������ϵ��*��������+��������ϵ��*�������ۣ�
    
    for k=1:size(S,2)
        Accept(:,k)=-1./(S(:,k)+1)+1; %ÿ�����пƼ����ܶ�,ȡֵ��Χ[0,1]
        S(:,k)=S(:,k).^(CoeT*k);
    end
    
    Need=S.*SpeedTec.*Accept.*People;%ÿ�����е�����������
    
    SSR=sum((sum(Need)-Flow').^2);
%     SST=sum((sum(Need)-sum(Flow)/size(Flow,1)).^2);
    
%     ObjVal(i)=abs(SSR/SST-1);

    ObjVal(i)=SSR;
    
    if CoeIncome==0||CoeAge==0||SpeedTec==0
        ObjVal(i)= 10*ObjVal(i);
    end

end


end