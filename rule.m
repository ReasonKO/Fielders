%function rules=Rule(Robots)

global Robots
global alg_par

alg_par.rule_step=1;

n=length(Robots);
sum_nearest_theta=zeros(1,n);
sum_nearest_d=zeros(n,2);
neightbors_robots=zeros(1,n);
nearest_robots=zeros(1,n);

%% Step g4
for i=1:n
        for j=1:length(Robots)        
            neightbors_robots(j)=(norm(Robots(i).p-Robots(j).p)<alg_par.rc);
            nearest_robots(j)=(norm(Robots(i).p-Robots(j).p)<min(alg_par.rc,alg_par.rs));
            if nearest_robots(j)
                sum_nearest_theta(i)=sum_nearest_theta(i)+Robots(j).theta;
                sum_nearest_d(i,:)=sum_nearest_d(i,:)+Robots(j).d+Robots(j).p;
            end        
        end
        %% step 6) update G
        Robots(i).theta=sum_nearest_theta(i)/sum(nearest_robots);
        Robots(i).d=sum_nearest_d(i,:)/sum(nearest_robots)-Robots(i).p;
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
    alg_graph.f300.s2=subplot(3,1,2);
    alg_graph.f300.s3=subplot(3,1,3);
    hold on

end
plotDataSet('Theta',Robots(n).theta,'Parent',alg_graph.f300.s1);
plotDataSet('Di1',Robots(n).d(1)+Robots(n).p(1),'Parent',alg_graph.f300.s2);
plotDataSet('Di2',Robots(n).d(2)+Robots(n).p(2),'Parent',alg_graph.f300.s3);

if ~ishandle(301) 
    figure(301)
    %axes('YScale','log')
    hold all        
end
for i=1:n-1
    ln=(sqrt((Robots(n).p(1)+Robots(n).d(1)-Robots(i).G.X).^2+(Robots(n).p(2)+Robots(n).d(2)-Robots(i).G.Y).^2));
    plotDataSetlogy(['LNtoD_',int2str(i)],min(min(ln)));
end
if ~ishandle(302) 
    figure(302)
    %axes('YScale','log')
    hold all
end
for i=1:n-1
    plotDataSetlogy(['theta_',int2str(i)],Robots(i).theta);        
end



