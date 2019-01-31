function outputImg = histAdjust(img)
    [rows, cols] = size(img);
    hist = zeros(1, 256);
    % generate hist
    for i = 1 : rows
        for j = 1 : cols
            hist(img(i, j) + 1) = hist(img(i, j) + 1) + 1;
        end
    end
    % integral hist
    s = cumsum(hist);
    s = s * 255 / numel(img);
    outputImg = uint8(reshape(s(img(:) + 1), size(img)));
end
