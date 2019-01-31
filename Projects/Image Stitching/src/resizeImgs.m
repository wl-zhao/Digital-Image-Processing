% resize imgs in imd
function imgs = resizeImgs(imd, max_size)
    imgs = readall(imd);
    img_size = size(imgs{1}, 1);
    for i = 1 : numel(imd.Files)
        if img_size > max_size
            imgs{i} = imresize(imgs{i}, max_size / img_size);
        end
    end
end