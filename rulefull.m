%function rules=Rule(Robots)

global Robots
global alg_par
n=length(Robots);
sum_nearest_theta=zeros(1,n);
sum_nearest_d=zeros(n,2);
neightbors_robots=zeros(1,n);
nearest_robots=zeros(1,n);

%% Step g4
for i=1:n
    if Robots(i).step==1
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
        if min(min(ln))<alg_par.rtr
            %g8 a)
            B=ln<2*alg_par.rl0+alg_par.rtr;
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
        Robots(i).step=1.5;
    elseif Robots(i).step==2
        ln=sqrt((Robots(i).p(1)-Robots(i).G.X).^2+(Robots(i).p(2)-Robots(i).G.Y).^2);
        [~,ind]=min(ln(:));
        Robots(i).Gc.x=Robots(i).G.X(ind);
        Robots(i).Gc.y=Robots(i).G.Y(ind);
        Robots(i).G.oI=sqrt((Robots(i).Gc.x-Robots(i).G.X).^2+(Robots(i).Gc.y-Robots(i).G.Y).^2)<=alg_par.sr0*1.5;
        Robots(i).G.oI=Robots(i).G.oI&Robots(i).G.I;
        for j=1:n
            if i~=j
                B=sqrt((Robots(j).p(1)-Robots(i).G.X).^2+(Robots(j).p(2)-Robots(i).G.Y).^2)<alg_par.rtr;
                Robots(i).G.oI=Robots(i).G.oI&not(B);
            end
        end
        Robots(i).G.oI(ind)=true;
        nG=sum(sum(Robots(i).G.oI));
        tempX=Robots(i).G.X(Robots(i).G.oI);
        tempY=Robots(i).G.Y(Robots(i).G.oI);
        if nG<=1
            Robots(i).C=Robots(i).p;
        else
            rnd=randi([1,nG],1,1);
            Robots(i).C=[tempX(rnd),tempY(rnd)];
        end
        Robots(i).step=2.5;
    elseif Robots(i).step==1.5
        if Robots(i).p-Robots(i).C<alg_par.rtr
            Robots(i).step=2;
        end
    elseif Robots(i).step==2.5
        if Robots(i).p-Robots(i).C<alg_par.rtr
            Robots(i).step=1;
        end
    end
end

