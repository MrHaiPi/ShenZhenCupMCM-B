%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%载入相关数据
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global ERang EPhase E EL AZ

load('raw_data.mat');
EL=raw_data.EL./180*pi;%垂直角
AZ=raw_data.AZ./180*pi;%水平角
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


ERang=10.^(LogMag./20);%电压幅度
EPhase=Phase;%电压相位，弧度

E=ERang.*exp(1i.*EPhase);
E(:,:,13,:)=rot90(E(:,:,20,:),2);
E(:,:,28,:)=rot90(E(:,:,5,:),2);


%     err=0.3;
%     I=[89 20 3 4 50 6 7 8 9 1 11 1 1 14 15 16   0 18 19 20 21 22 23 24 2 2 27 28 9 30 31 2];
%     Dlanmuda=0.05;
%     Rlanmuda=1;
%     Fai=0.8;
%     a=[9 2 3 4 50 6 7 8 9 1 11 1 1 14 1.5 16   0 18 19 2 21 2 23 4 2 2 27 28 9 30 31 20];
%     b=[2 2 3 4 5 6 7 80 9 1 11 12 13 1 30 1   17 18 1 20 21 2 23 24 5 26 27 28 29 30 31 2];
%     C=(a(1)+1i*b(1))*eye(32);
%     for m=2:32
%         C=C+diag((a(m)+1i*b(m))*ones(1,32-m+1),m-1)+diag((a(m)+1i*b(m))*ones(1,32-m+1),-(m-1));
%     end
%     V=zeros(size(EL));
%     Llanmuda=0.25;
%     Hlanmuda=0.25;
%     
%     f1=cos(2*pi*Llanmuda*cos(EL).*sin(AZ))-cos(2*pi*Llanmuda);
%     f2=sqrt(1-(cos(EL).*sin(AZ)).^2);
%     f=f1./f2;
%     f(19,19)=0;
%     f(55,19)=0; 
%     for m=1:32
%          V=V+C(m,1).*exp(1i*2*(m-1)*pi*Dlanmuda*(cos(Fai).*cos(EL).*sin(AZ)+sin(Fai).*sin(EL)));
%     end
%     for k=1:32
%         if k==13||k==28
%             continue;
%         end
%         
%         for j=1:1
%              E_temp(:,:,k,j)=1i*60*I(k)*...
%                     exp(1i*((j-1)*pi/2+err-2*pi*Rlanmuda)).*...
%                     (1-exp(-1i*4*pi*Hlanmuda.*cos(AZ).*cos(EL))).*f.*V;
% 
%         end
%     end
% 
% temp1=E(:,:,13,1);
% temp2=E(:,:,20,1);
% theta=0:pi/36:pi;  %定义theta角的范围（0-pi）
% phi=0:pi/36:2*pi;   %定义j角的范围（0-2pi）
% [tt,pp]=meshgrid(theta,phi); %把空间分为空间角的单元
% %幅度图
%         figure(1);
%         r=abs(temp1);
%         [x,y,z]=sph2cart(pp,pi/2-tt,r);  %把球坐标转化成笛卡尔坐标
%         mesh(x,y,z); %绘制网格图形
%         surf(x,y,z,r); %绘制三维曲面
%         axis equal;
% 
%         figure(2);
%         r=abs(temp2);
%         [x,y,z]=sph2cart(pp,pi/2-tt,r);  %把球坐标转化成笛卡尔坐标
%         mesh(x,y,z); %绘制网格图形
%         surf(x,y,z,r); %绘制三维曲面
%         axis equal;
% surf(EL,AZ,E_k);


% Ir=1078.1;
% Le=69.9;
% Rlanmuda=132.25;
% Hlanmuda=1;
%     
%     f=cos(2*pi*Le*cos(EL).*sin(AZ))-cos(2*pi*Le);
%     f2=sqrt(1-(cos(EL).*cos(AZ)).^2);
%     f=f./f2.*.2.*sin(2*pi*Hlanmuda.*cos(EL).*cos(AZ));
%     
%     f(find(isnan(f)))=0;
%     
%     E_temp=1i*60*Ir*exp(1i*(-2*pi*Rlanmuda)).*f;
%     
% E_temp=abs(E_temp);
%幅度图
%  surf(EL,AZ,abs(E_temp(:,:,1,1)));    

    