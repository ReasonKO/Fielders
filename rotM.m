function [Xout,Yout] = rotM(X,Y,ang,v)
Xout=cos(ang)*X-sin(ang)*Y+v(1);
Yout=sin(ang)*X+cos(ang)*Y+v(2);
end

