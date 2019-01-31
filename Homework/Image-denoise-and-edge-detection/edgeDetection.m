function output = edgeDetection(inputImg, s, sigma, threshold)
    % canny edge detection
    % Gaussian filter
    inputImg = double(inputImg) / 255;
    H = fspecial('gaussian', s, sigma);
    B = imfilter(inputImg, H);
    % finding the intensity gradient of the image
    Gx_H = fspecial('sobel')';
    Gy_H = fspecial('sobel');
    Gx = imfilter(B, Gx_H);
    Gy = imfilter(B, Gy_H);
    G = sqrt(Gx .^ 2 + Gy .^ 2);
    Theta = atan2(Gy, Gx);
    dir = angleDiscrete(Theta);
    
    dir = padarray(dir, [1, 1], nan);
    G = padarray(G, [1, 1], nan);
    tmp_G = zeros(size(G));
    % Non-maximum suppression
    for i = 2 : size(G, 1) - 1
        for j = 2 : size(G, 2) - 1
            switch dir(i, j)
                case 0
                    if G(i, j) < G(i, j + 1) || G(i, j) < G(i, j - 1)
                        tmp_G(i, j) = 0;
                    else
                        tmp_G(i, j) = G(i, j);
                    end
                case 1
                    if G(i, j) < G(i + 1, j + 1) || G(i, j) < G(i - 1, j - 1)
                        tmp_G(i, j) = 0;
                    else
                        tmp_G(i, j) = G(i, j);
                    end
                case 2
                    if G(i, j) < G(i + 1, j) || G(i, j) < G(i - 1, j)
                        tmp_G(i, j) = 0;
                    else
                        tmp_G(i, j) = G(i, j);
                    end
                case 3
                    if G(i, j) < G(i + 1, j - 1) || G(i, j) < G(i - 1, j + 1)
                        tmp_G(i, j) = 0;
                    else
                        tmp_G(i, j) = G(i, j);
                    end
            end
        end
    end
    G = tmp_G;
    % double threshold
    week = (G > threshold(1)) .* (G < threshold(2));
    strong = G > threshold(2);
    
    % edge tracking
    for i = 1 : size(G, 1)
        for j = 1 : size(G, 2)
            if week(i, j)
                if strong(i, j + 1) || strong(i, j - 1) || strong(i - 1, j) || strong(i + 1, j) || ...
                        strong(i + 1, j + 1) || strong(i + 1, j - 1) || strong(i - 1, j - 1) || strong(i - 1, j + 1)
                    G(i, j) = threshold(2);
                end
            end
        end
    end
    G = G(2 : size(G, 1) - 1, 2 : size(G, 2));
    output = G > threshold(2);
end

% get discrete gradient direction
function direction = angleDiscrete(theta)
    if theta < 0, theta = theta + 2 * pi; end
    direction = mod(floor(4 * theta / pi), 4);
end