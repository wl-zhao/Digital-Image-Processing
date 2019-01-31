% author: Zhao Wenliang
% function DFS
% input:
%   i, j: the row and column index from which we start the DFS
%   type: connectivity type, must be 4 or 8
function DFS(i, j)
    global flag;
    global nbr_dp;
    global s;
    global G;
    global n_pixel;
    global c_type;
    
    for nbr_n = 1 : c_type
        nbr = [i, j] + nbr_dp(nbr_n, :);
        x = nbr(1);
        y = nbr(2);
        % out of range
        if x < 1 || x > s(1) || y < 1 || y > s(2)
            continue;
        end
        % unvisited and white, do DFS recursively
        if G(x, y) == 1 && flag(x, y) == 0
            flag(x, y) = 1;
            n_pixel = n_pixel + 1;
            DFS(x, y);
        end
    end
end