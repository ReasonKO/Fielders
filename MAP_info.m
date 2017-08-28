function MAP_info
% �������� ������������ ���� � ���������� myplotgui � ��� ������� Figure 1
global Modul
Modul.Minfo.H = figure(99);
clf
set(Modul.Minfo.H,'Name', 'MAP_info', 'NumberTitle', 'off')
set(Modul.Minfo.H,'Position',[100 100 420 100])

% �������� ����
%hA = axes('Position', [0.1 0.2 0.8 0.7]);
% �������� ������ � ������� �������� Callback �������� ��������� �� ����������

Modul.Minfo.Hb = uicontrol('Style', 'pushbutton', ...
     'Position', [285 20 120 60],...
    'String', 'STOP',...
    'FontSize',18,...
    'Callback', @BtnStopCallback);

Modul.Minfo.Htime = uicontrol('Style', 'text', ...
     'Position', [150 20 120 30],...
    'String', 0,...
    'FontSize',12);
Modul.Minfo.HtimeLabel = uicontrol('Style', 'text', ...
     'Position', [150 50 120 30],...
    'String', ['time'],...% (',int2str(Modul.Tend),')'],...
    'FontSize',12);

Modul.Minfo.Hrun = uicontrol('Style', 'text', ...
     'Position', [20 30 120 40],...
    'String', 'RUN',...
    'BackgroundColor',[0,1,0],...
    'FontSize',21);

function BtnStopCallback(src,evt)
global Modul
Modul.Stop=true;
set(Modul.Minfo.Hrun,'String', 'STOP');
Modul
fprintf('\n-------GUI STOP------\n')
set(Modul.Minfo.Hb,'Callback', @BtnStartCallback);
set(Modul.Minfo.Hb,'String', 'Start');


function BtnStartCallback(src,evt)
global Modul
Modul.Stop=false;
Modul
fprintf('\n-------____ START ____------\n')
set(Modul.Minfo.Hb,'Callback', @BtnStopCallback);
set(Modul.Minfo.Hb,'String', 'Stop');
MODUL
