%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���߹滮
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ObjVal = p_2_1_3(Chrom,count)

global...
LineData Need_Plan Line CoeNeed CoeLine Distance

%�����ֵ����
ObjVal=zeros(size(Chrom,1),1);%�����ֵ��ʼ��
for i=1:size(Chrom,1)
    
    %���߳ɱ����㣨����*�۸�*��Ŀ��
    Line(count,end)=Distance(count)*LineData(1,4)*Chrom(i,1)+...
                  Distance(count)*LineData(2,4)*Chrom(i,2)+...
                  Distance(count)*LineData(3,4)*Chrom(i,3);

    %����Լ������(�����߲���ͬʱΪ0) 
    if Chrom(i,1)==0&&Chrom(i,2)==0&&Chrom(i,3)==0   
        Line(count,end)=inf;   
    end
    %�ٶ�Լ������
    if Need_Plan(count,end)/(365*24*60*60)*(1.5)>Chrom(i,1)*LineData(1,1)+...
                   Chrom(i,2)*LineData(2,1)+...
                   Chrom(i,3)*LineData(3,1)        
        Line(count,end)=inf;
    end
    %����Լ������
    if (Chrom(i,1)~=0 && Distance(count)>LineData(1,2))||...
       (Chrom(i,2)~=0 && Distance(count)>LineData(2,2))||... 
       (Chrom(i,3)~=0 && Distance(count)>LineData(3,2))
       Line(count,end)=inf;
    end
    
    ObjVal(i)=CoeNeed*Need_Plan(count,end)-CoeLine*Line(count,end);
    
end

ObjVal=-ObjVal;%�������ֵ����ת��Ϊ����Сֵ����

end


