% author: Zhao Wenliang
% main function, calculate the number of connected domain

% img1
% connectivity 4
[img1_4, pix1_4] = get_connected_domain('img1.bmp', 4);
% connectivity 8
[img1_8, pix1_8] = get_connected_domain('img1.bmp', 8);

% img2
% connectivity 4
[img2_4, pix2_4] = get_connected_domain('img2.bmp', 4);
% connectivity 8
[img2_8, pix2_8] = get_connected_domain('img2.bmp', 8);

% display number of connected domains 
connected_domains = [img1_4, img1_8, img2_4, img2_8]

% display number of pixels in each connected domain 
pix1_4, pix1_8, pix2_4, pix2_8




