global Robots Modul alg_par
n=length(Robots);
for i=1:n
    speed=alg_par.sr0;
    c=Robots(i).C-Robots(i).p;
    cln=norm(c);
    if cln>alg_par.rtr
        mln=min(cln,speed*Modul.dt);
        mc=c/cln*mln;
        Robots(i).p=Robots(i).p+mc;
        %Относительное смещение
        Robots(i).d=Robots(i).d-mc;
    end
end

MAP


