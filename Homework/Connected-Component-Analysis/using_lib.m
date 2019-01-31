% author: Zhao Wenliang
% using matlab library functions for comparation

[L1_4, N1_4] = bwlabel(imread('img1.bmp'), 4);
pix1_4_lib = using_lib_count(L1_4, N1_4);
[L1_8, N1_8] = bwlabel(imread('img1.bmp'), 8);
pix1_8_lib = using_lib_count(L1_8, N1_8);
[L2_4, N2_4] = bwlabel(imread('img2.bmp'), 4);
pix2_4_lib = using_lib_count(L2_4, N2_4);
[L2_8, N2_8] = bwlabel(imread('img2.bmp'), 8);
pix2_8_lib = using_lib_count(L2_8, N2_8);

% display number of connected domains 
connected_domains_lib = [N1_4, N1_8, N2_4, N2_8]

% display number of pixels in each connected domain 
pix1_4_lib, pix1_8_lib, pix2_4_lib, pix2_8_lib