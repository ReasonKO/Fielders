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

% TEXT
text_vis_ln=3;
test_sd=3;
for MAP_i=1:length(Robots)
    MAP_DATA.Robots(MAP_i).text_N=MAP_i;
end
for MAP_i=1:length(Robots)    
    count=0;
    if MAP_DATA.Robots(MAP_i).text_N==MAP_i     
        for MAP_j=1:length(Robots)
            if norm(Robots(MAP_i).p-Robots(MAP_j).p)<text_vis_ln
                count=count+1;
                MAP_DATA.Robots(MAP_j).text_N=MAP_i;
            end
        end
        
  
    
    end
    if count>1
        set(MAP_DATA.Robots(MAP_i).h_text_counter,'Visible','on');   
        set(MAP_DATA.Robots(MAP_i).h_text_counter,'Position',[Robots(MAP_i).p+[test_sd,test_sd],0]);
        set(MAP_DATA.Robots(MAP_i).h_text_counter,'String',int2str(count));   
    else
        set(MAP_DATA.Robots(MAP_i).h_text_counter,'Visible','off');    
    end
end

global exp1_data
if ~isfield(exp1_data,'track')
        exp1_data.track{n}=plot(Robots(n).p(1),Robots(n).p(2),'R-','Linewidth',1.5);
          exp1_data.track{n-1}=plot(Robots(n-1).p(1),Robots(n-1).p(2),'G-','Linewidth',1.5);
          exp1_data.track{n-2}=plot(Robots(n-2).p(1),Robots(n-2).p(2),'K-','Linewidth',1.5);
else      
         addPlotData(exp1_data.track{n},Robots(n).p(1),Robots(n).p(2)); %Узлы внутри поля
         addPlotData(exp1_data.track{n-1},Robots(n-1).p(1),Robots(n-1).p(2)); %Узлы внутри поля
         addPlotData(exp1_data.track{n-2},Robots(n-2).p(1),Robots(n-2).p(2)); %Узлы внутри поля
end
         %drawnow
if isfield(Modul,'T')
    set(Modul.Minfo.Htime,'String',Modul.T);
end
drawnow
end