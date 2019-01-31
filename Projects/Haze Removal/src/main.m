%% get all image from dataset
clear dataset;
dirs = dir('../dataset');
dataset{numel(dirs) - 2} = {};
for i = 3 : numel(dirs)
    dataset{i - 2} = dirs(i).name;
end

%% get all the results automatically
dataset_pre = '../dataset/';
result_pre = '../results/';
for i = 1 : numel(dataset)
    disp(dataset{i});
    I = im2double(imread([dataset_pre dataset{i}]));
    J_He = dehaze_He(I);
    J_Kim = dehaze_Kim(I);
    imwrite(I, [result_pre dataset{i}(1 : end - 4) '.jpg']);
    imwrite(J_He, [result_pre dataset{i}(1 : end - 4) '_He.jpg']);
    imwrite(J_Kim, [result_pre dataset{i}(1 : end - 4) '_Kim.jpg']);
end