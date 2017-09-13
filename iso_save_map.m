function iso_save_map(forsesave)
if nargin==0
    forsesave=0;
end
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
        if (floor((Modul.T)/Modul.save_freq+1e-10)~=floor((Modul.T+Modul.dt)/Modul.save_freq+1e-10) || forsesave)
            saveas(MAP_DATA.MAP_H,[MAP_DATA.SAVEMAP.name,'/','map',sprintf('%.3d',MAP_DATA.SAVEMAP.tick),'_t',int2str(floor(Modul.T+1e-10)),'.',int2str(mod(roundn(Modul.T,1),1)*10),'.png']);
            if (mod(roundn(Modul.T,1),1)*10)~=0 && Modul.save_freq==1
                mod(roundn(Modul.T,1),1)*10
                int2str(mod(roundn(Modul.T,1),1)*10)
                
                warning('0.1\n');
            end
            MAP_DATA.SAVEMAP.tick=MAP_DATA.SAVEMAP.tick+1;
        end
    end
end