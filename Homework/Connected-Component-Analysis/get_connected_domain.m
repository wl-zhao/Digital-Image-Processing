% author: Zhao Wenliang
% function get_connected_domain
% input: 
%   filename: a string of the name of the picture, e.g. 'img1.bmp'
%   type: connectivity type, must be 4 or 8
% output:
%   n: the number of connected domain
%   pix: the number pixels in each connected domain

function [n, pix] = get_connected_domain(filename, connect_type)
    % visit flag
    global flag;
    % neighbor position difference
    global nbr_dp;
    % graph
    global G;
    % size
    global s;
    % pixel count
    global n_pixel;
    % connectivity type
    global c_type;
    % initial
    c_type = connect_type;
    n = 0;
    G = imread(filename) / 255;
    s = size(G);
    flag = zeros(s);
    nbr_dp = [ -1,  0;
                1,  0;
                0,  1;
                0, -1;
               -1, -1;
                1, -1;
                1,  1;
               -1,  1;];
    pix = zeros(1, ceil(numel(G) / 2));
    % main loop
    for i = 1 : s(1)
        for j = 1 : s(2)
            if flag(i, j) == 0 && G(i, j) == 1 % new domain found
                n = n + 1;
                flag(i, j) = 1;
                n_pixel = 1;
                DFS(i, j); % DFS to find the whole domain
                pix(n) = n_pixel;
            end
        end
    end
    pix = sort(pix(1:n));
end