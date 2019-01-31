% get sift features and descriptors
function [f, d] = SIFT(imgs)
    imgNum = numel(imgs);
    f = cell(imgNum, 1);
    d = cell(imgNum, 1);
    for i = 1 : imgNum
        [f{i}, d{i}] = getSiftFeature(imgs{i}, 5);
    end
end
function [f, d] = getSiftFeature(img, edge_thresh)
    max_sift = 20000;
    I = rgb2gray(img);
    I = single(I);
    [f, d] = vl_sift(I, 'edgethresh', edge_thresh);
    nf = size(f, 2);
    if nf > max_sift
        disp(['nf = ' num2str(nf)]);
        subset = vl_colsubset(1 : nf, max_sift) ;
        f = f(:, subset);
        d = d(:, subset);
    end
end