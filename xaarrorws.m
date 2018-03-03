
clear, clc
figure
 

t = 0:0.1:10;
% рисуем какое-то безумие:
x = cos(t);
y = t.*x.*sin(t);
 
plot(x,y);
grid on
 
axx = [x(11) x(12)];
ayy = [y(11) y(12)];
[arrowx,arrowy] = dsxy2figxy(gca, [0.5,0.6], [1,2]);
annotation('arrow',arrowx,arrowy);