function outputImg = sineAdjust(img, alpha)
   img = im2double(img);
   outputImg = uint8(255 * min(1, max(0, img + sin(pi * double(img)) * alpha))); 
end

