function [IN,range]=exp4_Field(X,Y,modR)


X=abs(X);
Y=abs(Y);

d=15;
z=1.23;
L=z*d/(z-1);

range1=(X*z-d*z-Y)/sqrt(z^2+1);
range2=(Y*z-d*z-X)/sqrt(z^2+1);
range3=sqrt((X-L).^2+(Y-L).^2);
range3((X<L)|(Y<L))=NaN;
range=max(max((range1),(range2)),range3);

IN=range<modR;
end