close all; clear; 

load 'data';

Bd1=X(:,:,1); Bd1 = normalize(Bd1); Bd2=X(:,:,2);  Bd2 = normalize(Bd2);
Bd3=X(:,:,3);  Bd3 = normalize(Bd3); Bd4=X(:,:,4);  Bd4 = normalize(Bd4);
Bd5=X(:,:,5); Bd5 = normalize(Bd5); Bd6=X(:,:,6);  Bd6 = normalize(Bd6)
B_d1=Y(:,:,1); B_d1 = normalize(B_d1); B_d2=Y(:,:,2); B_d2 = normalize(B_d2); 
B_d3=Y(:,:,3); B_d3 = normalize(B_d3); B_d4=Y(:,:,4); B_d4 = normalize(B_d4); 
B_d5=Y(:,:,5); B_d5 = normalize(B_d5); B_d6=Y(:,:,6); B_d6 = normalize(B_d6);

N_X=cat(3,Bd1,Bd2,Bd3,Bd4,Bd5,Bd6); N_Y=cat(3,B_d1,B_d2,B_d3,B_d4,B_d5,B_d6);

%% M calculation
D_A=[];
D_B=[];
I=padarray(X(:,:,1),[pd pd],'replicate');
[m1,n11]=size(I); 
for i=w-pd:m1-pd
    for j=w-pd:n11-pd
        for k=1:6
I=padarray(N_X(:,:,k),[pd pd],'replicate');
I1=padarray(N_Y(:,:,k),[pd pd],'replicate');

         D=I(i-pd:i+pd,j-pd:j+pd);               % 3x3 block of t1 image mag
         D1=I1(i-pd:i+pd,j-pd:j+pd);             % 3x3 block of t2 image mag
%         MU_IN(i-pd,j-pd)= mi(D,D1);
%         MU_IN(i-pd,j-pd)= mi(D_A,D_B);

    D_A=[D_A,D];
    D_B=[D_B,D1];
        end
 MU_IN(i-pd,j-pd)= mi(D_A,D_B);
 D_A=[];
D_B=[];
     end
   
end

%   save ('MU_IN_all,'MU_IN');
 