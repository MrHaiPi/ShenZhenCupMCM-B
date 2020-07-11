%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%设置模型参数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global...
Flow City Now LineData...
People CoePeople Need Line Accept SpeedTec...
AvGdp CoeAvGdp Uincome CoeUincome Rincome...
CoeRincome Sincome Sage CoeIncome CoeAge...
S CoeNeed CoeLine AgeStru Distance CoeT

%参数初始化
City=20;
Now=2017;%最新数据对应的时间 
X=1;%标准成本
LineData=[400/8 200 32 X;600/8 100 48 1.25*X;800/8 80 64 1.5*X];%可选线相关的参数
Flow=10000*xlsread('广东2012-2017互联网接入流量.xlsx','b2:b7')+...%单位/GB
     10000*xlsread('广东2012-2017互联网接入流量.xlsx','d2:d7');
People=10000*xlsread('广东2012-2017各市总人口(含增长率).xls','b2:g22');%单位/人
Distance=xlsread('广东各城市到广州的实际距离和规划距离.xlsx','b2:b21');%单位/千米
AvGdp=xlsread('广东2012-2017各市全体居民人均收入(含增长率).xls','b2:g22');%每个城市平均GDP，单位/元
Uincome=xlsread('广东2012-2017各市城镇居民人均收入(含增长率).xls','b2:g22');%每个城市城镇平均收入,单位/元
Rincome=xlsread('广东2012-2017各市农村居民人均收入(含增长率).xls','b2:g22');%每个城市农村平均收入，单位/元
AgeStru=xlsread('广东各城市人口结构比例.xlsx','b2:d22');%各城市人口结构比例

CoePeople=xlsread('广东2012-2017各市总人口(含增长率).xls','h2:h22');%人口增长率
CoeAvGdp=xlsread('广东2012-2017各市全体居民人均收入(含增长率).xls','h2:h22');%各城市平均GDP增长系数
CoeUincome=xlsread('广东2012-2017各市城镇居民人均收入(含增长率).xls','h2:h22');%各城市城镇平均收入增长系数
CoeRincome=xlsread('广东2012-2017各市农村居民人均收入(含增长率).xls','h2:h22');%农村平均收入增长系数

CoeIncome=2.7746*10^-12;%收入评价系数
CoeAge=35.8625;%年龄评价系数
SpeedTec=219.2836;%技术进步系数
CoeT=0.0343;%指数函数系数

CoeNeed=1;%需求量转需求价值系数
CoeLine=1;%布线成本转布线价值系数

Sincome=AvGdp./(Uincome-Rincome);%每个城市的收入评价(城市平均GDP/（城镇平均收入-农村平均收入）)
Sage=(1*AgeStru(:,1)+3*AgeStru(:,2)+1*AgeStru(:,3))./5;%每个城市的年龄评价
Sage=repmat(Sage,1,6);%将Sage垂直方向复制1次，水平方向复制6次
S=CoeIncome.*Sincome+CoeAge.*Sage;%每个城市的综合评价（年龄评价系数*年龄评价+收入评价系数*收入评价）
Accept=-1./(S+1)+1; %每个城市科技接受度,取值范围[0,1]
for i=1:size(S,2)
    S(:,i)=S(:,i).^(CoeT*i);
end
Need=S.*SpeedTec.*Accept.*People;%每个城市的流量需求量
Line=zeros(size(Need));%每个城市的布线成本



