function plotDataSetlogy(h,x,varargin)
%if nargin<2
global Modul
global plotData_data

varData=varargin;


if ~(ischar(h) || ishandle(h))
    error('h not are name or handle');
end

generate_x=false;

if length(varData)>0 && ~ischar(varData{1})
    y=varData{1};
    varData={varData{2:end}};        
else
    y=x;
    if isfield(Modul,'T')
        x=Modul.T;
    else
        generate_x=true;
        x=NaN;
    end
end


%% можно добавить Z
hname=h;
if (ischar(h) && isfield(plotData_data,h)) %|| ishandle(h)
    h=getfield(plotData_data,h);    
    if generate_x
        x=length(get(h,'xdata'))+1;
    end
    set(h,'xdata',[get(h,'xdata'),x],'ydata',[get(h,'ydata'),y]);        
else
    if generate_x
        x=0;
    end
    if length(varData)==0
        h=semilogy(x,y);
    end
%     if length(varData)==1
%         h=plot(x,y,varData{1});
%     end
%     if length(varData)==2
%         h=plot(x,y,varData{1},varData{2});
%     end
%     if length(varData)==3
%         h=plot(x,y,varData{1},varData{2},varData{3});
%     end
%     if length(varData)==4
%         h=plot(x,y,varData{1},varData{2},varData{3},varData{4});
%     end
%     if length(varData)==5
%         h=plot(x,y,varData{1},varData{2},varData{3},varData{4},varData{5});
%     end
%     if length(varData)==6
%         h=plot(x,y,varData{1},varData{2},varData{3},varData{4},varData{5},varData{6});
%     end
%     if length(varData)>6
%         error('MAX LENGTH');
%     end    
    title(hname);
    plotData_data=setfield(plotData_data,hname,h);
end

end