function [IN,range]=exp5_Field(X,Y,modR)


range1=sqrt((X+50).^2+(Y-50).^2)-30;%+modR;
range2=sqrt((X-50).^2+(Y+50).^2)-30;%+modR;
range3=max(abs(X+50)-10,abs(Y-0)-60);
range4=max(abs(X)-60,abs(Y+50)-10);

range=min(min(min(range1,range2),range3),range4);

IN=range<modR;
end