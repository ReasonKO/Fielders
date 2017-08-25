
clear all
close all
global PAR

PAR.MAP_X=200;
PAR.MAP_Y=200;


global alg_par
alg_par.ExpName='exp4_star';

alg_par.r0=10; %Зона действия датчика
alg_par.rl0=alg_par.r0-1; %Зона действия датчика
alg_par.rc=alg_par.r0*2; %Зона комуникации
alg_par.rs=alg_par.r0*2; %Зона видимости
% rs>r0 (rs>2*rl0)
alg_par.rtr=0.5; %Зона необходимого сближения с сеткой
%rtr<(r0-rl0)/2
%2rtr<sqrt(3)rl0
alg_par.sr0=sqrt(3)*alg_par.rl0;
alg_par.sr0y=alg_par.sr0*sqrt(3)/2;

alg_par.Field=@(x,y,d)exp4_Field(x,y,d);

global Robots
Robots=struct('Active',[],'p',[],'d',[],'theta',[]);

n=100;
alg_par.ExpName=[alg_par.ExpName,'_n',int2str(n)];
for i=1:n
    %randomize
    
        Robots(i).Active=1;

    Robots(i).p=[rand(1)*2-1,rand(1)*6-3]*10;
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

[X,Y]=meshgrid(-100:1:100,-100:1:100);
[in,range]=inField(X,Y,0);
if ~isempty(range)
    maxrange=alg_par.rl0+alg_par.rtr/2;
    plot(X(range< maxrange & range> maxrange*0.9),Y(range< maxrange & range> maxrange*0.9),'.','color',[0.7,0.7,1]);
else
%plot(5+(80+alg_par.rl0+alg_par.rtr/2)*sin(temp),10+(80+alg_par.rl0+alg_par.rtr/2)*cos(temp),'B')
end
hmap=imagesc(-100:1:100,-100:1:100,1-in/10,'AlphaData',0.3);
temp=0:pi/30:(2*pi);
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
Modul.Tend=300;
Modul.dt=0.1;

Modul.SaveExp=1;
Modul.save_freq=1; 

MODUL