%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%天线问题1、2.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ObjVal = p_1_1(Chrom)

global E EL m_direction%水平角
E_temp=zeros(size(EL));
ObjVal=zeros(size(Chrom,1),1);
for i=1:size(Chrom,1)
    
for j=1:32
 
    E_temp=E_temp+Chrom(i,j).*E(:,:,j,Chrom(i,j+32));%天线问题一
%       E_temp=E_temp+E(:,:,j,Chrom(i,j));%天线问题二
    
end


E_temp=abs(E_temp);
Emax1=max(max(E_temp));
pos=find(E_temp==Emax1);
E_temp1=E_temp;
E_temp1(pos)=0;
Emax2=max(max(E_temp1));
     
ObjVal(i)=Emax2/Emax1+E_temp(39,21)+abs(E_temp(39,20)-10^(35/20));%天线问题一

%  m_row=32+ceil(m_direction/5)-1;
%  m_col=17+m_direction-1-(m_row-32)*5;
%     
% ObjVal(i)=Emax2/Emax1+abs(Emax1/E_temp(m_row,m_col)-1);%天线问题二

end

end