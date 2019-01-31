%% Read image
I = imread('lena.jpg');
%% non-local means denoise
J = fastNLM(I, 2, 10, 14);
figure();
imwrite(J, 'lena_denoise.jpg');
imshowpair(I, J, 'montage');
%% edge detection
edge1 = edgeDetection(I, 5, 1, [0.1, 0.2]);
edge2 = edgeDetection(J, 5, 1, [0.1, 0.2]);
figure();
imshowpair(edge1, edge2,  'montage');
