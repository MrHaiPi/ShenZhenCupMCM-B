%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%相关数据绘图
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all

load('骨干问题1广东2012-2028年各城市流量.mat');

year=[2012; 2013; 2014; 2015; 2016; 2017; 2018;
      2019; 2020; 2021; 2022; 2023; 2024; 2025;
      2026; 2027; 2028];
  
city=['深圳 ','珠海 ','汕头 ','佛山 ','韶关 ',...
      '河源 ','梅州 ','惠州 ','汕尾 ','东莞 ',...
      '中山 ','江门 ','阳江 ','湛江 ','茂名 ',...
      '肇庆 ','清远 ','潮州 ','揭阳 ','云浮 ','广州 '];

[X Y]=meshgrid(1:size(Need,2),1:size(Need,1));
figure(1);
surf(X,Y,Need);
shading interp
title(['2012-2028年广东各市需求流量']); 
x1=xlabel('年份');       
x2=ylabel('城市');        
x3=zlabel('需求流量/GB');        
set(x1,'Rotation',30);    
set(x2,'Rotation',-30); 

Need_Time=sum(Need);
figure(2);
plot(year,Need_Time);
title(['2012-2028年广东总需求流量']); 
xlabel('年份');            
ylabel('需求流量/GB');   

Need_City=Need(:,end);
figure(3);
bar(Need_City); 
title(['2028年广东各城市需求流量']); 
xlabel(city); 
ylabel('需求流量/GB'); 




