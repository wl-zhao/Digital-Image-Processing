function outputImg = interplotate(inputImg, u, v)
    outputImg = zeros([size(u), 3]);
    
    inside_v = ( v >= 1 ).* (v < size(inputImg, 1));
    inside_u = (u >= 1).*(u < size(inputImg, 2));
    inside = inside_v .* inside_u;
    % bilinear
    x1 = floor(u); y1 = floor(v);
    x2 = ceil(u); y2 = ceil(v);
    x2(x1 == x2) = x1(x1 == x2) + 1;
    y2(y1 == y2) = y1(y1 == y2) + 1;
    
    sub11 = size(inputImg, 1) * (x1 - 1) + y1; sub11(~inside) = 1;
    sub12 = size(inputImg, 1) * (x1 - 1) + y2; sub12(~inside) = 1;
    sub21 = size(inputImg, 1) * (x2 - 1) + y1; sub21(~inside) = 1;
    sub22 = size(inputImg, 1) * (x2 - 1) + y2; sub22(~inside) = 1;
   
    for c = 1 : 3
        inputImg_c = inputImg(:, :, c);
        outputImg(:, :, c) = (x2 - u) .* (y2 - v) .* inputImg_c(sub11) + ...
                             (x2 - u) .* (v - y1) .* inputImg_c(sub12) + ...
                             (u - x1) .* (y2 - v) .* inputImg_c(sub21) + ...
                             (u - x1) .* (v - y1) .* inputImg_c(sub22); 
    end
    inside3 = repmat(inside, [1, 1, 3]);
    outputImg(~inside3) = nan;
end