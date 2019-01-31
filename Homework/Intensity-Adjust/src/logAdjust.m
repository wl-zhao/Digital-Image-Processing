function outputImg = logAdjust(img, alpha)
    alpha = alpha * 10;
    outputImg = uint8(255 * log(1 + alpha * im2double(img)) / log(1 + alpha));
end