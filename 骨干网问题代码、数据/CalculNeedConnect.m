%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%计算考虑接入价值的规划流量
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
p_2_1_2;%需求量预估

Need_Connect=Need(:,end);%获取2028年的各市流量需求，单位/GB

p=1;
q=1;
REmin=1;%冗余度下限
REmax=1.5;%冗余度上限
ConnectValue=(AvGdp(:,end).^p).*Sage(:,end).^q;%接入价值
ConnectValue=ConnectValue./max(ConnectValue);
RE=REmin*(ConnectValue.*(REmax/REmin-1)+1);%各城市冗余度计算

Need_Connect=Need_Connect.*RE;


