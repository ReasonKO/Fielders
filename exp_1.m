
clear all
close all
global PAR

PAR.MAP_X=200;
PAR.MAP_Y=200;


global alg_par
alg_par.ExpName='exp1';

alg_par.r0=20; %Зона действия датчика
alg_par.rl0=alg_par.r0-1; %Зона действия датчика
alg_par.rtr=1; %Зона необходимого сближения с сеткой
alg_par.rc=round(alg_par.rl0*sqrt(3)+alg_par.rl0+2*alg_par.rtr+1); %Зона комуникации
alg_par.rs=round(alg_par.rl0*sqrt(3)+alg_par.rl0+2*alg_par.rtr+1); %Зона видимости
% rs>r0 (rs>2*rl0)
%rtr<(r0-rl0)/2
%2rtr<sqrt(3)rl0
alg_par.sr0=sqrt(3)*alg_par.rl0;
alg_par.sr0y=alg_par.sr0*sqrt(3)/2;

alg_par.step=1;

global Robots
Robots=struct('Active',[],'p',[],'d',[],'theta',[]);

n=100;
alg_par.ExpName=[alg_par.ExpName,'_n',int2str(n)];

for i=1:n
    %randomize

        Robots(i).Active=1;

    Robots(i).p=[rand(1)*2-1,rand(1)*2-1]*80;
    ang=rand(1)*2*pi;
    r=rand(1)*alg_par.r0;
    Robots(i).d=r*[cos(ang),sin(ang)];
    if i>1
    Robots(i).theta=rand(1)*pi/4+pi/3-pi/4;
    else
    Robots(i).theta=rand(1)*pi/3;
    end
    Robots(i).G.X=[];
    Robots(i).G.Y=[];
    Robots(i).G.I=[];
    Robots(i).G.sI=[];
    Robots(i).G.oI=[];
    Robots(i).C=Robots(i).p;
    Robots(i).step=1;
    Robots(i).Gc.x=[];
    Robots(i).Gc.y=[];
end

%% POLE INI

MAP_INI
set(MAP_DATA.Robots(n).h,'Color','R');
%set(MAP_DATA.Robots(n).h,'zdata',3);

[X,Y]=meshgrid(-100:1:100,-100:1:100);
in=inField(X,Y,0);
hmap=imagesc(-100:1:100,-100:1:100,1-in/10,'AlphaData',0.3);
temp=0:pi/30:(2*pi);
plot(5+(80+alg_par.rl0+alg_par.rtr/2)*sin(temp),10+(80+alg_par.rl0+alg_par.rtr/2)*cos(temp),'B')
colormap([176/255,196/255,222/255;1,1,1]);


MAP

rule    
rule2
addVisual

NeedSensors=sum(sum(Robots(n).G.I))


pause(3)
%% RUN
global Modul
Modul.T=0;
Modul.Tend=200;
Modul.dt=0.1;

Modul.SaveExp=1;
Modul.save_freq=0.33; 

MODUL