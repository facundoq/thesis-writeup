clc;
clear all;
iptsetpref('ImshowBorder','tight');

rango=10;
[x,y]=meshgrid(-rango:0.2:rango);
a1=[1 3];
y1=[0 1];
z= (x.*a1(1)-y1(1)).^2 + (y.*a1(2)-y1(2)).^2 ; 

[u,v] = gradient(z);
[r,c]= size(z);

w = ones(r,c);
contourf(x,y,z);
%surf(x,y,z);

scale=0.01;
hold on;
lh=quiver(x(1:20:end,1:20:end),y(1:20:end,1:20:end),-u(1:20:end,1:20:end),-v(1:20:end,1:20:end),'color',[1,1,1]);
set(lh,'linewidth',1.3);

%quiver3(x,y,z,-u,-v,w,scale,'color',[1,1,1]);

set(gca,'position',[0 0 1 1],'units','normalized')