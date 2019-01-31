%% read image
prefix = '../results/';
figure(1);
I = imread('../dataset/img.jpg');
subplot(241);
imshow(I);
title('原始图像');

%% denoise
denoise = imnlmfilt(I);
subplot(242);
imshow(denoise);
title('去噪后');
imwrite(denoise, [prefix 'denoise.jpg']);

%% illumination adjust
[illumination_adjusted, illumination, plot_data] = illumination_adjust(denoise);
subplot(243);
imshow(illumination);
imwrite(illumination, [prefix 'estimated_illumination.jpg']);
title('光照估计');
subplot(244)
imshow(illumination_adjusted);
title('照明调整后');
imwrite(illumination_adjusted, [prefix 'illumination_adjusted.jpg']);

%% binarize using ostu method
binarized = uint8(255 - ostu_binarize(illumination_adjusted));
subplot(245)
imshow(binarized);
title('二值化分割');
imwrite(binarized, [prefix 'binarized.jpg']);

%% remove isolated area
removed_isolated = remove_isolated(binarized);
subplot(246);
imshow(removed_isolated);
title('去除孤立区域');
imwrite(removed_isolated, [prefix 'removed_isolated.jpg']);

%% split eclipses
[eclipses, area_num, total] = split_eclipses(removed_isolated);
subplot(247);
imshow(total);
title('椭圆分割');

%% refine the binarize result using the information of eclipse 
subplot(248);
outputGIF = true;
results{area_num} = {};
combined_result = zeros(size(I));
imshow(total);
title('结果优化');
    
gw = GIFWriter;
gw.init('reconstruct_eclipse.gif', outputGIF);

subplot(248);
for i = 1 : area_num
    iter = i == 1;
    results{i} = reconstruct_eclipse(eclipses{i}, iter, gw);
    combined_result = combined_result + results{i};
    imwrite(results{i}, [prefix 'eclipses/' num2str(i) '.jpg']);
end

outputGIF = false;
if (outputGIF)
    gw.write();
end

subplot(248);
imshow(combined_result);
title('最终结果');
imwrite(combined_result, [prefix 'final_result.jpg']);