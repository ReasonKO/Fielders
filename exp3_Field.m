function [IN,range]=exp3_Field(X,Y,modR)


range1=sqrt((X-0).^2+(Y-50).^2)-30;%+modR;
range2=sqrt((X-0).^2+(Y+50).^2)-30;%+modR;
range3=max(abs(X-0)-10,abs(Y-0)-40);
range=min(min(range1,range2),range3);

IN=range<modR;
end