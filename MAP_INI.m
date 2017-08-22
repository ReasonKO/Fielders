
global Robots
clear MAP_DATA
global MAP_DATA
MAP_DATA={};
MAP_DATA.MAP_H=figure(100);
clf
hold on;grid off;
xlabel('metres');
ylabel('metres');
global PAR;
if (isempty(PAR))
    warning('PAR is not initialized');
    return;
end
axis equal
axis([-PAR.MAP_X/2,PAR.MAP_X/2,-PAR.MAP_Y/2,PAR.MAP_Y/2,0,2]);
set(gca,'Color',[0.95 0.95 0.95]);


MAP_DATA.Robots=struct('h',{});
for i=1:length(Robots)
    MAP_DATA.Robots(i).h=plot3(NaN,NaN,0.1,'B.','MarkerSize',25);
end