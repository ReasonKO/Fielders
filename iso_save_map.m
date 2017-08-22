function iso_save_map()

global MAP_DATA alg_par Modul
if (isfield(MAP_DATA,'MAP_H') && ishandle(MAP_DATA.MAP_H) && isequal('on',get(MAP_DATA.MAP_H,'Visible')))
    if (~isempty(Modul) && Modul.SaveExp)
        if (~isfield(MAP_DATA,'SAVEMAP'))
            MAP_DATA.SAVEMAP.tick=0;
            MAP_DATA.SAVEMAP.freq=Modul.save_freq;    
            c=clock;
            if ~isfield(alg_par,'ExpName')
                alg_par.ExpName=[];
            end
            MAP_DATA.SAVEMAP.name=sprintf('%s(%d.%02d.%02d-%02d.%02d)',alg_par.ExpName,c(1),c(2),c(3),c(4),c(5));
            mkdir(MAP_DATA.SAVEMAP.name);
        end
        if (mod(MAP_DATA.SAVEMAP.tick,MAP_DATA.SAVEMAP.freq)==0 || Modul.T>=Modul.Tend)
            saveas(MAP_DATA.MAP_H,[MAP_DATA.SAVEMAP.name,'/','map',int2str(MAP_DATA.SAVEMAP.tick),'.png']);
        end
        MAP_DATA.SAVEMAP.tick=MAP_DATA.SAVEMAP.tick+1;
    end
end