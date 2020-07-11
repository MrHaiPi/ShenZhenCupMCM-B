%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%天线问题二
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ObjVal = p_1_2(Chrom)

global ME_max 

ObjVal=zeros(size(Chrom,1),1);
S1=30.71;
S2=14.27;
for i=1:size(Chrom,1)
AreaOver=0;
for k=1:size(ME_max,1)
     
    if Chrom(i,k)==0
        continue;
    end
    
    if mod(k,5)~=0&&k+1<=55&&Chrom(i,k+1)==1%判断右方是否有波束
        AreaOver=AreaOver+S1;
    end
    
    if mod(k,5)~=0&&k+5+1<=55&&Chrom(i,k+5+1)==1%判断右下方是否有波束
        AreaOver=AreaOver+S2;
    end
    
    if k+5<=55&&Chrom(i,k+5)==1%判断下方是否有波束
        AreaOver=AreaOver+S1;
    end
    
    if mod(k,5)~=1&&k+5-1<=55&&Chrom(i,k+5-1)==1%判断左下方是否有波束
        AreaOver=AreaOver+S2;
    end
%     m_row=32+ceil(k/5)-1;
%     m_col=17+k-1-(m_row-32)*5;
    
end

   Number=sum(Chrom(i,:));%波束个数
   Power=10*log10(sum(ME_max(find(Chrom(i,:)==1)).^2)/72);%平均功率
   Area1=sum(Chrom(i,:))*25*pi-AreaOver;%波束覆盖面积
   Area2=1800-Area1;%凹坑面积
   ObjVal(i)=Number*(4*Area2/1800+abs(Power-35));

end

end