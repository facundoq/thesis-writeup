clc;
clear all;
rango=10;
[x,y]=meshgrid(-rango:.2:rango);
a1=[9 15];
y1=[50 10];
z= (x.*a1(1)-y1(1)).^2 + (y.*a1(2)-y1(2)).^2 ;
surf(x,y,z);
