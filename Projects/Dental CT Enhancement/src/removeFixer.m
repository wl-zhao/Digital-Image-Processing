% remove fixer decided by lineMask
function outputImg = removeFixer(Img, lineMask, blurLen, threshold)
    if nargin == 3
        threshold = -1;
    end
    [yy, xx] = ind2sub(size(Img), find(lineMask > 0));
    outputImg = Img;

    % blur the bound of fixer
    for i = 1 : length(yy)
        y = yy(i);
        x = xx(i);
        if ((size(threshold, 2) == 1 && y < threshold) || (size(threshold, 2) == 2 && (y > threshold(2) || y < threshold(1))))
            continue;
        end
        for d = 1 : blurLen
             outputImg(y, x - d : x + d) = (outputImg(y, x - d : x + d) + interpolate(x - d, x + d, Img(y, x - d), Img(y, x + d))) / 2;
        end
    end
end

function y = interpolate(x1, x2, y1 ,y2)
    if (x2 == x1)
        y = y1;
        return;
    end
    b = -(y2 - y1) / (x2 - x1) * 3 / 2;
    a = 4 * b / (3 * (x2 - x1) ^ 2);
    x = x1 : x2;
    x_mean = mean([x1, x2]);
    f = @(x)(a * (x - x_mean) .^3 - b * (x - x_mean) + mean([y1, y2]));
    y = f(x);
end