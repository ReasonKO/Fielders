%function rules=Rule(Robots)

global Robots
global alg_par

alg_par.rule_step=1;

n=length(Robots);
sum_nearest_theta=zeros(1,n);
sum_nearest_d=zeros(n,2);
neightbors_robots=zeros(n,n);
nearest_robots=zeros(n,n);

%% Step g4
for i=1:n
        for j=1:length(Robots)        
            neightbors_robots(i,j)=(norm(Robots(i).p-Robots(j).p)<alg_par.rc);
            nearest_robots(i,j)=(norm(Robots(i).p-Robots(j).p)<min(alg_par.rc,alg_par.rs));
            if nearest_robots(i,j)
                sum_nearest_theta(i)=sum_nearest_theta(i)+Robots(j).theta;
                sum_nearest_d(i,:)=sum_nearest_d(i,:)+Robots(j).d+Robots(j).p;
            end        
        end
end
for i=1:n
    %% step 6) update G
    Robots(i).theta=sum_nearest_theta(i)/sum(nearest_robots(i,:));
    Robots(i).d=sum_nearest_d(i,:)/sum(nearest_robots(i,:))-Robots(i).p;
    [Robots(i).G.X,Robots(i).G.Y,Robots(i).G.I]=getRG(Robots(i).theta,Robots(i).d+Robots(i).p);
    %% step 7) Distence to G
    ln=(sqrt((Robots(i).p(1)-Robots(i).G.X).^2+(Robots(i).p(2)-Robots(i).G.Y).^2));
    %% Step g8
    if min(min(ln))>alg_par.rtr
        %g8 a)
        B=ln<alg_par.rl0+alg_par.rtr;
        %g8 b)
        Robots(i).G.sI=B&Robots(i).G.I;
        %g8 c)
        nG=sum(sum(Robots(i).G.sI));
        tempX=Robots(i).G.X(Robots(i).G.sI);
        tempY=Robots(i).G.Y(Robots(i).G.sI);
        if nG==0
            Robots(i).C=Robots(i).p;
        else
            rnd=randi([1,nG],1,1);
            Robots(i).C=[tempX(rnd),tempY(rnd)];
        end
    else
        Robots(i).C=Robots(i).p;
    end
end


global alg_graph
if ~ishandle(300) 
    figure(300)
    alg_graph.f300.s1=subplot(3,1,1);
    hold on
    title('Theta');
    alg_graph.f300.s2=subplot(3,1,2);
    hold on
    title('Di_x');
    alg_graph.f300.s3=subplot(3,1,3);
    hold on
    title('Di_y');
    hold on

end
plotDataSet('Theta',Robots(n).theta,'Parent',alg_graph.f300.s1);
plotDataSet('Di_x',Robots(n).d(1)+Robots(n).p(1),'Parent',alg_graph.f300.s2);
plotDataSet('Di_y',Robots(n).d(2)+Robots(n).p(2),'Parent',alg_graph.f300.s3);

if ~ishandle(301) 
    figure(301)
    %axes('YScale','log')
    hold all        
end
sumln=0;
for i=1:n-1
    ln=(sqrt((Robots(n).p(1)+Robots(n).d(1)-Robots(i).G.X).^2+(Robots(n).p(2)+Robots(n).d(2)-Robots(i).G.Y).^2));
    sumln=sumln+min(min(ln));
    plotDataSetlogy(['LNtoD_',int2str(i)],min(min(ln)));
end
    plotDataSetlogy('LNtoD_sr',sumln/n,'LineWidth',4);
%global plotData_data

if ~ishandle(302) 
%    set( plotData_data.LNtoD_sr','LineWidth',2);
    figure(302)
    %axes('YScale','log')
    hold all
end
for i=1:n-1
    plotDataSetlogy(['theta_',int2str(i)],Robots(i).theta);        
end

if ~ishandle(303) 
%    set( plotData_data.LNtoD_sr','LineWidth',2);
    figure(303)
    plot(0,1,'W');
    %axes('YScale','log')
    hold all
end

[X,Y]=meshgrid(-100:1:100,-100:1:100);
in=inField(X,Y,0);

%% Граффики заполнености
% global lnctopouint
% lnctopouint_prev=lnctopouint;
% if isempty(lnctopouint_prev)
% lnctopouint_prev=zeros(size(in));
% end
% lnctopouint=zeros(size(in));
% for i=1:n
%     lnctopouint=lnctopouint|(sqrt((Robots(i).p(1)-X).^2+(Robots(i).p(2)-Y).^2)<alg_par.r0);    
% end
% lnctopouint=lnctopouint&in;
% a=sum(sum(in));
% b=sum(sum(lnctopouint));
% c=sum(sum(lnctopouint|lnctopouint_prev));
% plotDataSet('FIELDpercent',b/a,'linewidth',2);
% plotDataSet('FIELDpercent2',c/a,'linewidth',2);
%% 


%b/a
% plot(X(~lnctopouint),Y(~lnctopouint),'R.');
% plot(X(~in),Y(~in),'B.');
% plot(X(lnctopouint),Y(lnctopouint),'Y.');


