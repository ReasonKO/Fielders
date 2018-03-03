%% GIFER
%% ------------------------------------
[files, pathname] = uigetfile( ...
{ '*.png','.png images'; ...
   '*.*',  'All Files (*.*)'}, ...
   'Pick a images for GIF creating','MultiSelect', 'on');
dir=pathname;
dirstring=[dir,'\','gif'];
mkdir(dirstring);   
if ~iscell(files)
    fprintf('!You pick only one picture!\n');
    n=1;
    temp=files;
    clear files
    files{1}=temp;
else
    n=length(files);
    fprintf('%d images\n',n);
end
%% delays
% StartDelayTime=0.8;
% DelayTime=0.2;
answer= inputdlg({'Start delay:','delay:'}, ['settings'],1,{'0.8','0.2'});
[StartDelayTime,status1]=str2num(answer{1});
[DelayTime,status2]=str2num(answer{2});
if ~status1 || ~status2
    error('Delay time need digit');
end
%% displayed
    figure(1)
    clf
%% Creating
idx=0;
for i=1:n
if ~isempty(regexp(files{i},'.png'))
    filename=files{i};
    fprintf('%d/%d %s\n',i,n,filename);
    [X, map] = imread([dir,'\',filename],'png');
    %% displayed
        image(X);
        colormap(map)
        axis off          % Remove axis ticks and numbers
        axis image 
        drawnow
    %%
    idx=idx+1;
    [A,map] = rgb2ind(X,256);
    if idx == 1
        imwrite(A,map,[dirstring,'\movie.gif'],'gif','LoopCount',Inf,'DelayTime',StartDelayTime);
    else
        imwrite(A,map,[dirstring,'\movie.gif'],'WriteMode','append','DelayTime',DelayTime);
    end
end
end

