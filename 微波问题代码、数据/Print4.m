clc
clear all
close all

ReadData;
load('��������2�ನ������.mat');
ME_max=load('��������2,55�����ö�Ӧ��ǿ���ֵ.mat');
ME_max=ME_max.value';
Configure=load('��������2,55��������λ����.mat');
Configure=Configure.Solutions;
E_max=zeros(73,37);
for i=1:55
    
    if Solutions(i)==0
        continue;
    end
    
    E_temp=zeros(73,37);
    for j=1:32
        E_temp=E_temp+E(:,:,j,Configure(i,j));
    end
    E_temp=abs(E_temp);
    for m=1:73
        for n=1:37
            if E_temp(m,n)>E_max(m,n)
                E_max(m,n)=E_temp(m,n);
            end
        end
    end
    
    m_row=42-ceil(i/5)+1;
    m_col=17+i-1-(42-m_row)*5;

    x=m_col;
    y=m_row;
    
    r = 1; 
    theta=0:0.01:2*pi ; % Բ��������
    Circle1=x+r*cos(theta);
    Circle2=y+r*sin(theta);
    plot(Circle1,Circle2,'Color','r','linewidth',1);
    hold on;
    plot(x,y,'b*');
    hold on;
    axis([15 23 30 44])
    axis equal
       
end
rectangle('Position',[16,31,6,12]);
xbins=-35:10:40;
ybins=35:-10:-40;
set(gca,'XTickLabel',xbins);%����Ҫ��ʾ����̶�
set(gca,'YTickLabel',ybins); 
title([]); 
x1=xlabel('����/��');       
x2=ylabel('ˮƽ�н�/��');    

figure(2);
E_max=20*log10(flipud(E_max));
contourf(E_max(25:49,9:29),25);
colorbar;
axis equal
% xbins=-45:10:50;
% ybins=45:-10:-50;
% set(gca,'XTickLabel',xbins);%����Ҫ��ʾ����̶�
% set(gca,'YTickLabel',ybins); 
title([]); 
x1=xlabel('����/��');       
x2=ylabel('ˮƽ�н�/��');     


AreaOver=0;
S1=30.71;
S2=14.27;
for k=1:size(ME_max,1)
    
    if Solutions(k)==0
        continue;
    end
    
    if mod(k,5)~=0&&k+1<=55&&Solutions(k+1)==1%�ж��ҷ��Ƿ��в���
        AreaOver=AreaOver+S1;
    end
    
    if mod(k,5)~=0&&k+5+1<=55&&Solutions(k+5+1)==1%�ж����·��Ƿ��в���
        AreaOver=AreaOver+S2;
    end
    
    if k+5<=55&&Solutions(k+5)==1%�ж��·��Ƿ��в���
        AreaOver=AreaOver+S1;
    end
    
    if mod(k,5)~=1&&k+5-1<=55&&Solutions(k+5-1)==1%�ж����·��Ƿ��в���
        AreaOver=AreaOver+S2;
    end
    
end

   Number=sum(Solutions);%��������
   Power=10*log10(sum(ME_max(find(Solutions==1)).^2)/72);%ƽ������
   Area1=sum(Solutions)*25*pi-AreaOver;%�����������
   Area2=1800-Area1;%�������
   ObjVal=Number*(2*Area2/1800+abs(Power-35));


