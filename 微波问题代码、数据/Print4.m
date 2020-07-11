clc
clear all
close all

ReadData;
load('天线问题2多波束配置.mat');
ME_max=load('天线问题2,55个配置对应场强最大值.mat');
ME_max=ME_max.value';
Configure=load('天线问题2,55个方向相位配置.mat');
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
    theta=0:0.01:2*pi ; % 圆滑性设置
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
set(gca,'XTickLabel',xbins);%设置要显示坐标刻度
set(gca,'YTickLabel',ybins); 
title([]); 
x1=xlabel('仰角/°');       
x2=ylabel('水平夹角/°');    

figure(2);
E_max=20*log10(flipud(E_max));
contourf(E_max(25:49,9:29),25);
colorbar;
axis equal
% xbins=-45:10:50;
% ybins=45:-10:-50;
% set(gca,'XTickLabel',xbins);%设置要显示坐标刻度
% set(gca,'YTickLabel',ybins); 
title([]); 
x1=xlabel('仰角/°');       
x2=ylabel('水平夹角/°');     


AreaOver=0;
S1=30.71;
S2=14.27;
for k=1:size(ME_max,1)
    
    if Solutions(k)==0
        continue;
    end
    
    if mod(k,5)~=0&&k+1<=55&&Solutions(k+1)==1%判断右方是否有波束
        AreaOver=AreaOver+S1;
    end
    
    if mod(k,5)~=0&&k+5+1<=55&&Solutions(k+5+1)==1%判断右下方是否有波束
        AreaOver=AreaOver+S2;
    end
    
    if k+5<=55&&Solutions(k+5)==1%判断下方是否有波束
        AreaOver=AreaOver+S1;
    end
    
    if mod(k,5)~=1&&k+5-1<=55&&Solutions(k+5-1)==1%判断左下方是否有波束
        AreaOver=AreaOver+S2;
    end
    
end

   Number=sum(Solutions);%波束个数
   Power=10*log10(sum(ME_max(find(Solutions==1)).^2)/72);%平均功率
   Area1=sum(Solutions)*25*pi-AreaOver;%波束覆盖面积
   Area2=1800-Area1;%凹坑面积
   ObjVal=Number*(2*Area2/1800+abs(Power-35));


