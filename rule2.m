%function rules=Rule(Robots)

global Robots
global alg_par

alg_par.rule_step=2;
n=length(Robots);


for i=1:n
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
end
