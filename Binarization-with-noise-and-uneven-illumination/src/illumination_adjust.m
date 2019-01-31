function [outputImg, light, plot_data] = illumination_adjust(I)
    I = im2double(I);
    x = 1 : size(I, 2);
    y = double(mean(I, 1));
    p = polyfit(x, y, 2);
    yy = polyval(p, x);
    light = repmat(yy, size(I, 1), 1);
    outputImg = uint8(I ./ light * 255);
    plot_data = [x; y; yy];
end