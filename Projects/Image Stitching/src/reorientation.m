% Preprocess the images to be properly oriented
function reorientation(directory)  
    imgNameList = dir([directory '/*.jpg']);
    for i = 1 : numel(imgNameList)
        imgPath = [directory '/' imgNameList(i).name];
        I = imread(imgPath);
        info = imfinfo(imgPath);
        if ~isfield(info,'Orientation')
            continue;
        end
        orient = info(1).Orientation;
        switch orient
            case 1
                %normal, leave the data alone
            case 2
                I = I(:, end:-1:1, :);
            case 3
                I = I(end:-1:1, end:-1:1, :);
            case 4
                I = I(end:-1:1, :, :);
            case 5
                I = permute(I, [2 1 3]);
            case 6
                I = rot90(I, 3);
            case 7
                I = rot90(I(end:-1:1, :, :));
            case 8
                I = rot90(I);
            otherwise
                warning('unknown orientation %g ignored\n', orient);
        end
        imwrite(I, imgPath);
    end
end
