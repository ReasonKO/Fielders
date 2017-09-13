global Robots
global exp1_data

global alg_par 
robot=Robots(n);

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

setka_M=[Xl1,Xl2,Xl3]+robot.d(1)+robot.p(1);
setka_N=[Yl1,Yl2,Yl3]+robot.d(2)+robot.p(2);
ang=(0:pi/10:2*pi)';
Kc=[cos(ang),sin(ang)]*alg_par.rs;

if ~isfield(exp1_data,'Setka_h');
    figure(100)
    exp1_data.Setka_h=plot(setka_M,setka_N,'color',[0,0,0]);%,'AlphaData',0.98);
    exp1_data.p_h=plot(NaN,NaN,'.','MarkerSize',7,'color',[0,0,0]);
    %exp1_data.p_h2=plot(X(in2),Y(in2),'Go');
    %exp1_data.d_h3=plot(robot.p(1)+robot.d(1),robot.p(2)+robot.d(2),'Ro','MarkerSize',5);
    exp1_data.d_h4=plot(NaN,NaN,'G*','MarkerSize',9);
    exp1_data.d_h5=plot(NaN,NaN,'R-');
    exp1_data.d_h6=plot(NaN,NaN,'Ro','MarkerSize',13);
    %exp1_data.d_h7=plot(robot.Gc.x,robot.Gc.y,'R*');

end
    for i=1:length(exp1_data.Setka_h)
        setPlotData(exp1_data.Setka_h(i),setka_M(:,i),setka_N(:,i));
    end
    setPlotData(exp1_data.d_h4,robot.C(1),robot.C(2)); %цель
    if alg_par.addviz
        setPlotData(exp1_data.d_h6,robot.G.X(robot.G.oI)',robot.G.Y(robot.G.oI)');
        setPlotData(exp1_data.d_h5,robot.p(1)+Kc(:,1),robot.p(2)+Kc(:,2)); %окружность видимости
    end    
    %setPlotData(exp1_data.d_h3,robot.p(1)+robot.d(1),robot.p(2)+robot.d(2)); %главная вершина сетки
    setPlotData(exp1_data.p_h,X(in1),Y(in1)); %Узлы внутри поля
    %setPlotData(exp1_data.p_h2,X(in2),Y(in2));    

