global PAR alg_par

[X,Y]=meshgrid(-PAR.MAP_X/2:10:PAR.MAP_X/2,-PAR.MAP_Y/2:10:PAR.MAP_Y/2)
figure(100)
n_=size(X,1)*size(X,2);
for i=1:n_
    in=inField(X,Y,alg_par.rl0+alg_par.rtr/2);
    plot(X(in),Y(in),'G.');
    plot(X(~in),Y(~in),'R.');

end
