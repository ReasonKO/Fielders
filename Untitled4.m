load clown
figure(6)
%subplot(1,2,1)
[x,y]=meshgrid(1:320,1:200)
imagesc(-160:160,1:200,X)
colormap(gray)
axis image
title('Default CLim (= [1 81])')