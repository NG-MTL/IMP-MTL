close all; clear; 
load('data');
load('Yam_2_band6.mat','Y');


A=double(X1);
B=double(X2); 

load MU_IN_all;
Th_mi=mean2(MU_IN);

idx=MU_IN>Th_mi;

%% pixels 
indx_1 = find(idx == 1);
indx_0 = find(idx == 0);


mean_1 = mean(A(indx_1));
mean_0 = mean(A(indx_0));

mean_12 = mean(B(indx_1));
mean_02 = mean(B(indx_0));

Mid_val=((abs(mean_1-mean_12))+(abs(mean_0-mean_02)))/2;


Var_0=std(A(indx_0));
Var_1=std(A(indx_1));

Var_02=std(B(indx_0));
Var_12=std(B(indx_1));

S1=size(indx_1,1); S2=size(indx_0,1);
Temp_var=((((S1-1)*Var_1)+((S1-1)*Var_12))+((S1^2/(2*S1))*((mean_1)^2+(mean_12)^2-2*mean_1*mean_12)))/((2*S1)-1);
G_var=sqrt(Temp_var);

%% Padding
w=5;                      %%box size
pd=w-round(w/2);
I=padarray(A,[pd pd],'replicate');
I1=padarray(B,[pd pd],'replicate');
[m1,n11]=size(I);


%% Sepation
for i= w-pd:m1-pd
    for j=w-pd:n11-pd
        O_B=I(i-pd:i+pd,j-pd:j+pd);               % 3x3 block of t1 image mag
         O_B1=I1(i-pd:i+pd,j-pd:j+pd);
         O_B_B1=[O_B,O_B1];
         M_B_B1(i-pd,j-pd)=mean2(O_B_B1);
         SD_C(i-pd,j-pd)=std(O_B_B1(:));
         SD(i-pd,j-pd)=std(O_B(:));  SD1(i-pd,j-pd)=std(O_B1(:));
         MD(i-pd,j-pd)=mean2(O_B(:));  MD1(i-pd,j-pd)=mean2(O_B1(:));
        V_B = sum(abs( O_B(:) - M_B_B1(i-pd,j-pd)).^2) ./ (w*w); S_B (i-pd,j-pd)= sqrt(V_B);
        V_B1 = sum(abs( O_B1(:) - M_B_B1(i-pd,j-pd)).^2) ./ (w*w); S_B1(i-pd,j-pd) = sqrt(V_B1);
    end
end

%% CM
 
for i= w-pd:m1-pd
    for j=w-pd:n11-pd
        if  ((abs(MD(i-pd,j-pd)-MD1(i-pd,j-pd)))>Mid_val) && (SD_C(i-pd,j-pd)>G_var/1)
            
            CM_V(i-pd,j-pd)=0;
        else
            CM_V(i-pd,j-pd)=1;
        end
    end
end

    
 figure;imshow(CM_V,[]);  impixelinfo;  