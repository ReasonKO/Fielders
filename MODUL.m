global Modul
Modul.Stop=false;
set(Modul.Minfo.Hrun,'BackgroundColor',[0,1,0]);
set(Modul.Minfo.Hrun,'String', 'RUN');
while Modul.T<Modul.Tend && ~Modul.Stop
    Modul.T=Modul.T+Modul.dt*16;
    
    for k=1:5
        MAP
        dynamic
    end
    iso_save_map
    iso_save_map
    for k=1:5
        MAP
        dynamic
    end
    rule    
    addVisual
    iso_save_map
    
    for k=1:5
        MAP
        dynamic
    end
    iso_save_map
    for k=1:5
        MAP
        dynamic
    end
    rule2    
    addVisual
    iso_save_map
end
iso_save_param
set(Modul.Minfo.Hrun,'BackgroundColor',[1,0,0]);
