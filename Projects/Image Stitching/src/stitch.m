% stitch the transformed imgs
function stitch(imgs_, root)
    global E;
    global pano;
    nImg = numel(imgs_);
    for i = 1 : size(E, 1)
        if E(root, i) == 1 % new child
            pano = multiband_blend(pano, imgs_{i}, nImg);
            E(root, i) = 0; E(i, root) = 0;
            stitch(imgs_, i);
        end
    end
end