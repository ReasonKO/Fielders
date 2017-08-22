function [Xnew,Ynew,In]=getRG(theta,d)
global alg_par PAR

dx=alg_par.sr0;
dy=alg_par.sr0y;

K=10;
%MX=[fliplr(-(dx:dx:((PAR.MAP_X)/2+dx))),0,(dx:dx:((PAR.MAP_X)/2+dx))];
%MY=[fliplr(-(dy:dy:((PAR.MAP_Y)/2+dy))),0,(dy:dy:((PAR.MAP_Y)/2+dy))];
MX=[-dx*K:dx:dx*K];
MY=[-dy*K:dy:dy*K];
[X,Y]=meshgrid(MX,MY);
 X(2:2:size(X,1),:)=X(2:2:size(X,1),:)+dx/2;

% 
% figure(4)
% hold on 
% axis equal
% axis([-300,300,-300,300]);
% plot(X,Y);
% plot(0,0,'R.');
% axis equal

[Xnew,Ynew]=rotM(X,Y,theta,d);

In=inField(Xnew,Ynew,alg_par.rl0);
end