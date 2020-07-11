%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%球坐标绘图
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all

load('raw_data.mat');
load('天.mat');
% load('天线问题1相位配置.mat');
% load('天线问题2,55个方向相位配置.mat');
EL=raw_data.EL;
AZ=raw_data.AZ;
LogMag_ini=raw_data.LogMag;
Phase_ini=raw_data.Phase;

for i=1:16
LogMag(:,:,i,:)= LogMag_ini(:,:,16-i+1,:);
Phase(:,:,i,:)=flipud(Phase_ini(:,:,16-i+1,:));
end
LogMag(:,:,17:24,:)=LogMag_ini(:,:,25:32,:);
LogMag(:,:,25:32,:)=LogMag_ini(:,:,17:24,:);
Phase(:,:,17:24,:)=Phase_ini(:,:,25:32,:);
Phase(:,:,25:32,:)=Phase_ini(:,:,17:24,:);

LogMag(:,:,13,:)=rot90(LogMag(:,:,20,:),2);
LogMag(:,:,28,:)=rot90(LogMag(:,:,5,:),2);
Phase(:,:,13,:)=rot90(Phase(:,:,20,:),2);
Phase(:,:,28,:)=rot90(Phase(:,:,5,:),2);

theta=0:pi/36:pi;  %定义theta角的范围（0-pi）
phi=0:pi/36:2*pi;   %定义j角的范围（0-2pi）
[tt,pp]=meshgrid(theta,phi); %把空间分为空间角的单元


phase_choose=4;
initial_phase=4;
% Solutions=ones(1,64);
for j=1:55
    r=zeros(73,37);
for i=1:32
    
%     phase_choose=rem((initial_phase+i-1),4);%等间相位
%     if phase_choose==0
%        phase_choose=4;
%     end

%     phase_choose=Solutions(i+32);
%     m=Solutions(i);
      phase_choose=Solutions(j,i);
      m=1;
    
    if ~isnan(LogMag(:,:,i,phase_choose))
        
        ERang=10.^(LogMag(:,:,i,phase_choose)./20);%电压幅度
        EPhase=Phase(:,:,i,phase_choose);%电压相位，弧度
        
        r=r+m*ERang.*exp(1i.*EPhase);
        
    
%         r=abs(r);
% 
%         m=i;
%         if i>8&&i<=16
%             m=16-(i-8-1);
%         end
%         if i>24&&i<=32
%             m=32-(i-24-1);
%         end
%         subplot(4,8,m);
%         [x,y,z]=sph2cart(pp,pi/2-tt,r);  %把球坐标转化成笛卡尔坐标
%         mesh(x,y,z); %绘制网格图形
%         surf(x,y,z,r); %绘制三维曲面
%         axis equal;
%         colorbar;
%         surf(EL,AZ,r);
        
     end

end

r=abs(r);
% r=20.*log10(r);
% value(j)=max(max(r));
end
% filename='天线问题2,55个配置对应场强最大值.mat';
% save (filename,'value');


figure(1);
[x,y,z]=sph2cart(pp,pi/2-tt,r);  %把球坐标转化成笛卡尔坐标
mesh(x,y,z); %绘制网格图形
surf(x,y,z); %绘制三维曲面
axis equal;

figure(2);
surf(EL,AZ,r);

% subplot(1,2,1);
figure(3);
b=bar3(r);
c = colorbar;
c.Label.String = 'P/dBm';
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
xbins=-90:10:90;
ybins=-180:10:180;
set(gca,'XTickLabel',xbins);%设置要显示坐标刻度
set(gca,'YTickLabel',ybins); 
set(gca,'YTick',1:2:74);
set(gca,'XTick',1:2:38);
title([]); 
x1=xlabel('仰角/°');       
x2=ylabel('水平夹角/°');        
x3=zlabel('P/dBm');        
% set(x1,'Rotation',30);    
% set(x2,'Rotation',-30); 


