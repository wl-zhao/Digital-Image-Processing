function outputImg = linearAdjust(img, alpha, beta)
    img = im2double(img);
    img = img * alpha + beta;
    img(img > 1) = 1;
    img(img < 0) = 0;
    outputImg = uint8(floor(img * 255));
    if (all(outputImg == 255, [1, 2]))
        outputImg = outputImg - 1;
    end
end