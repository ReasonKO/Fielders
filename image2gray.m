%close all
%clear all

saveas(100,['test100map.png']);

filename='test100map.png';
[X, map] = imread(filename,'png');

Y = rgb2gray(X);
Y2=repmat(Y,[1,1,3]);
imwrite(Y2,['gray_',filename],'png');

hf=figure(101);
subplot(2,1,1)
%figure('color','k','Position',[0000 018 1201 901])
axis([0,1200,0,900])
image(Y2)
colormap(map)
axis off          % Remove axis ticks and numbers
axis image 

subplot(2,1,2)
image(X)
axis off          % Remove axis ticks and numbers
axis image 
