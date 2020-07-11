%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%�������ͼ
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all

load('raw_data.mat');
load('��.mat');
% load('��������1��λ����.mat');
% load('��������2,55��������λ����.mat');
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

theta=0:pi/36:pi;  %����theta�ǵķ�Χ��0-pi��
phi=0:pi/36:2*pi;   %����j�ǵķ�Χ��0-2pi��
[tt,pp]=meshgrid(theta,phi); %�ѿռ��Ϊ�ռ�ǵĵ�Ԫ


phase_choose=4;
initial_phase=4;
% Solutions=ones(1,64);
for j=1:55
    r=zeros(73,37);
for i=1:32
    
%     phase_choose=rem((initial_phase+i-1),4);%�ȼ���λ
%     if phase_choose==0
%        phase_choose=4;
%     end

%     phase_choose=Solutions(i+32);
%     m=Solutions(i);
      phase_choose=Solutions(j,i);
      m=1;
    
    if ~isnan(LogMag(:,:,i,phase_choose))
        
        ERang=10.^(LogMag(:,:,i,phase_choose)./20);%��ѹ����
        EPhase=Phase(:,:,i,phase_choose);%��ѹ��λ������
        
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
%         [x,y,z]=sph2cart(pp,pi/2-tt,r);  %��������ת���ɵѿ�������
%         mesh(x,y,z); %��������ͼ��
%         surf(x,y,z,r); %������ά����
%         axis equal;
%         colorbar;
%         surf(EL,AZ,r);
        
     end

end

r=abs(r);
% r=20.*log10(r);
% value(j)=max(max(r));
end
% filename='��������2,55�����ö�Ӧ��ǿ���ֵ.mat';
% save (filename,'value');


figure(1);
[x,y,z]=sph2cart(pp,pi/2-tt,r);  %��������ת���ɵѿ�������
mesh(x,y,z); %��������ͼ��
surf(x,y,z); %������ά����
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
set(gca,'XTickLabel',xbins);%����Ҫ��ʾ����̶�
set(gca,'YTickLabel',ybins); 
set(gca,'YTick',1:2:74);
set(gca,'XTick',1:2:38);
title([]); 
x1=xlabel('����/��');       
x2=ylabel('ˮƽ�н�/��');        
x3=zlabel('P/dBm');        
% set(x1,'Rotation',30);    
% set(x2,'Rotation',-30); 


