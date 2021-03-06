%% �������� MAP_info
MAP_info

%% �������� ����� 100
global Robots
clear MAP_DATA
global MAP_DATA
MAP_DATA={};
MAP_DATA.MAP_H=figure(100);
set(MAP_DATA.MAP_H,'Name', 'MAP');
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

%% ������������� �������
MAP_DATA.Robots=struct('h',{});
for i=1:length(Robots)
    MAP_DATA.Robots(i).h2=plot3(NaN,NaN,0.1,'.','MarkerSize',25,'Color',[30,150,250]/255);
    MAP_DATA.Robots(i).h=plot3(NaN,NaN,0.1,'B.','MarkerSize',25);
    MAP_DATA.Robots(i).text_N=0;
    MAP_DATA.Robots(i).h_text_counter=text(0,0,'1','Visible','off','FontName','Franklin Gothic Medium Cond');    
end