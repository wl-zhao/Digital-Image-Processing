function outputImg = remove_isolated(I)
% remove isolated area of the input image
    se = strel('square', 3);
    outputImg = imerode(I, se);
%     h = fspecial('average', 3);
%     outputImg = I .* uint8(imfilter(im2double(I), h) > 0.9);
end

