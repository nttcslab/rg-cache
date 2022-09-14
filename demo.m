close all; clear all;

L = 4; % number of levels of image pyramid
e = 0.5; % parameter for reflectance scaling

filename = '1.png';
Cin = im2double(imread(filename));
[Cout1, Cout2] = rgcache(Cin, L, e);

figure(1); imshow(Cin); title('Input'); drawnow
figure(2); imshow(Cout1); title('RG-CACHE'); drawnow
figure(3); imshow(Cout2); title('RG-CACHE w/ RS'); drawnow
