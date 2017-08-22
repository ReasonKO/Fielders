function IN=inField(X,Y,modR)

x0=5;
y0=10;

IN=sqrt((X-x0).^2+(Y-y0).^2)<80+modR;

end