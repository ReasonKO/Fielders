global Robots
global exp1_data

global alg_par 
robot=Robots(20);

dx=alg_par.sr0;
dy=alg_par.sr0y;

Ky=12;
Lnx=200;

Xl=repmat([-Lnx;Lnx],[1,Ky*2+1]);
Yl=[-Ky:Ky;-Ky:Ky]*alg_par.sr0y;

[Xl1,Yl1]=rotM(Xl,Yl,robot.theta,[0,0]);
[Xl2,Yl2]=rotM(Xl1,Yl1,pi/3,[0,0]);
[Xl3,Yl3]=rotM(Xl1,Yl1,2*pi/3,[0,0]);



%[X,Y,in]=getRG(robot.theta,robot.d);
X=robot.G.X;
Y=robot.G.Y;
in1=robot.G.I;
in2=robot.G.sI;

M=[Xl1,Xl2,Xl3]+robot.d(1)+robot.p(1);
N=[Yl1,Yl2,Yl3]+robot.d(2)+robot.p(2);
ang=(0:pi/10:2*pi)';
Kc=[cos(ang),sin(ang)]*alg_par.rs;

if isfield(exp1_data,'Setka_h');
    for i=1:length(exp1_data.Setka_h)
        setPlotData(exp1_data.Setka_h(i),M(:,i),N(:,i));
    end
    setPlotData(exp1_data.d_h4,robot.C(1),robot.C(2)); %цель
    setPlotData(exp1_data.d_h5,robot.p(1)+Kc(:,1),robot.p(2)+Kc(:,2)); %окружность видимости

%    setPlotData(exp1_data.d_h3,robot.p(1)+robot.d(1),robot.p(2)+robot.d(2)); %главная вершина сетки
    setPlotData(exp1_data.p_h,X(in1),Y(in1)); %Узлы внутри поля

    setPlotData(exp1_data.p_h2,X(in2),Y(in2));
    
%    if alg_par.rule_step==2
 %   set(exp1_data.d_h6,'Visible','on');
 %   set(exp1_data.d_h7,'Visible','on');
    setPlotData(exp1_data.d_h6,robot.G.X(robot.G.oI)',robot.G.Y(robot.G.oI)');
    setPlotData(exp1_data.d_h7,robot.Gc.x,robot.Gc.y);
  %  else
%    set(exp1_data.d_h6,'Visible','off');
%    set(exp1_data.d_h7,'Visible','off');
   % end
else
    figure(100)
exp1_data.Setka_h=plot(M,N,'Y');%,'AlphaData',0.98);
exp1_data.p_h=plot(X(in1),Y(in1),'Yo');

%exp1_data.p_h2=plot(X(in2),Y(in2),'Go');
%exp1_data.d_h3=plot(robot.p(1)+robot.d(1),robot.p(2)+robot.d(2),'Ro','MarkerSize',5);
exp1_data.d_h4=plot(robot.C(1),robot.C(2),'G*','MarkerSize',10);

exp1_data.d_h5=plot(robot.p(1)+Kc(:,1),robot.p(2)+Kc(:,2),'R-');

exp1_data.d_h6=plot(robot.G.X(robot.G.oI)',robot.G.Y(robot.G.oI)','Ro','MarkerSize',13);
exp1_data.d_h7=plot(robot.Gc.x,robot.Gc.y,'R*');


end
