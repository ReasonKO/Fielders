global MAP_DATA PAR Modul
global Robots;
if (isfield(MAP_DATA,'MAP_H') && ishandle(MAP_DATA.MAP_H) && isequal('on',get(MAP_DATA.MAP_H,'Visible')))
%% BEGIN 

%vis_ln=20;

for MAP_i=1:length(Robots)
        if (Robots(MAP_i).Active) && isfield(MAP_DATA.Robots,'h') && ~isempty(MAP_DATA.Robots(MAP_i).h)
            viz_x=Robots(MAP_i).p(1);
            viz_y=Robots(MAP_i).p(2);
            set(MAP_DATA.Robots(MAP_i).h,'xdata',viz_x,'ydata',viz_y);
        end           
end
%drawnow
if isfield(Modul,'T')
    set(Modul.Minfo.Htime,'String',Modul.T);
end
drawnow
end