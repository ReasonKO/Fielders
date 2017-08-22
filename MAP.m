global MAP_DATA PAR 
global Robots;
if (isfield(MAP_DATA,'MAP_H') && ishandle(MAP_DATA.MAP_H) && isequal('on',get(MAP_DATA.MAP_H,'Visible')))
%% BEGIN 

%vis_ln=20;

for MAP_i=1:length(Robots)
        if (Robots(MAP_i).Active)
            viz_x=Robots(MAP_i).p(1);
            viz_y=Robots(MAP_i).p(2);
            if (isfield(MAP_DATA.Robots,'h') && ~isempty(MAP_DATA.Robots(MAP_i).h))
                set(MAP_DATA.Robots(MAP_i).h,'xdata',viz_x,'ydata',viz_y);
            end
        end           
end

drawnow
end