% generate gaussian or laplacian pyramid
function P = pyramid(img, levels, filtersize, type, sigma)
    if nargin == 5
        if strcmp(type, 'gaussian')
            P{levels} = {};
            kernel=fspecial('gaussian', filtersize, sigma);
            P{1} = img;
            P_last = P{1};
            for L = 2 : levels  
                P_tmp = P_last;
                P_tmp = imfilter(P_tmp, kernel);
                P{L} = P_tmp(2 : 2 : size(P_last, 1), 2 : 2 : size(P_last, 2), : );
                P_last = P{L};
            end
        else
            if strcmp(type, 'laplacian')
                GP = pyramid(img, levels, filtersize, 'gaussian', sigma);
                P{levels, 3} = {};
                for L = 1 : levels - 1
                    P{L} = double(GP{L}) - imresize(GP{L + 1}, size(GP{L}(:, :, 1)));
                end
                P{levels} = double(GP{levels});
            end
        end
    end
end