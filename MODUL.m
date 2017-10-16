global Modul
Modul.Stop=false;
set(Modul.Minfo.Hrun,'BackgroundColor',[0,1,0]);
set(Modul.Minfo.Hrun,'String', 'RUN');


while Modul.T<Modul.Tend %&& ~Modul.Stop
    Modul.T
    if ceil(Modul.T)-ceil(Modul.T+Modul.dt)~=0
        if alg_par.step==1
            rule    
        else
            rule2
        end
        MAP
        alg_par.step=1-alg_par.step;
        addVisual
        iso_save_map(1);
    end 
    MAP
    
    iso_save_map
    dynamic
    MAP
    iso_save_map
    Modul.T=Modul.T+Modul.dt;
end
iso_save_param
iso_save_map(1);
set(Modul.Minfo.Hrun,'BackgroundColor',[1,0,0]);
