%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%���㿼�ǽ����ֵ�Ĺ滮����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
p_2_1_2;%������Ԥ��

Need_Connect=Need(:,end);%��ȡ2028��ĸ����������󣬵�λ/GB

p=1;
q=1;
REmin=1;%���������
REmax=1.5;%���������
ConnectValue=(AvGdp(:,end).^p).*Sage(:,end).^q;%�����ֵ
ConnectValue=ConnectValue./max(ConnectValue);
RE=REmin*(ConnectValue.*(REmax/REmin-1)+1);%����������ȼ���

Need_Connect=Need_Connect.*RE;


