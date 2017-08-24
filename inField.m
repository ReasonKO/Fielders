function [IN,range]=inField(X,Y,modR)
global alg_par
range=[];
if isfield(alg_par,'Field') && ~isempty(alg_par.Field)
    [IN,range]=alg_par.Field(X,Y,modR);
else
    x0=5;
    y0=10;

    IN=sqrt((X-x0).^2+(Y-y0).^2)<80+modR;
end

end