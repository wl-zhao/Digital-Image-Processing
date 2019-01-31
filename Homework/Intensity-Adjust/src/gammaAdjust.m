function outputImg = gammaAdjust(img, gamma)
    img = im2double(img);
    outputImg = uint8(255 * img .^ gamma);
end