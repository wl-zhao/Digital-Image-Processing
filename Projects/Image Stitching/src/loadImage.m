% load images from dir
function imgs =  loadImage(dir)
    reorientation(dir);
    imd = imageDatastore(fullfile(dir));
    imgs = resizeImgs(imd, 800);
end