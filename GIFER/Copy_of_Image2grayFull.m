% global MAP_DATA dir
% dir=
% if ~isempty(MAP_DATA) & isfield(MAP_DATA,'SAVEMAP');
%     dir=[MAP_DATA.SAVEMAP.name,'\'];
%     files=ls(dir);
% else
%     files=ls;
%     dir=[];
% end
dir='GRAYM/'
files=ls(dir);

mkdir([dir,'gray']);   
n=size(files,1);
for i=1:n
	if ~isempty( regexp(files(i,:),'.png'))
        filename=files(i,:);
        [X, map] = imread([dir,filename],'png');
        fprintf('%d/%d %s\n',i,n,filename);
        
for i=1:656
    for j=1:875
        if X(i,j,1)>100 && X(i,j,2)>100 && X(i,j,3)<100
           % [X(i,j,1),X(i,j,2),X(i,j,3)]
            X(i,j,1)=0;
        end
    end
end
        Y = rgb2gray(X);
        Y2=repmat(Y,[1,1,3]);
        imwrite(Y2,[dir,'gray\gray_',filename],'png');
% 
%             hf=figure(101);
%             subplot(2,1,1)
%             %figure('color','k','Position',[0000 018 1201 901])
%             axis([0,1200,0,900])
%             image(Y2)
%             colormap(map)
%             axis off          % Remove axis ticks and numbers
%             axis image 
% 
%             subplot(2,1,2)
%             image(X)
%             axis off          % Remove axis ticks and numbers
%             axis image 
%             return
    end
end