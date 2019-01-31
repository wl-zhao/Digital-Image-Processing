function [pano, imgs_, centerImageIdx] = getTransformedImgs(imgs)
    global final_H;
    global E;
    global H;
    % calculate limit
    % Compute the output limits  for each transform
    nImg = numel(imgs);
    xlim = zeros(nImg, 1, 2);
    ylim = zeros(nImg, 1, 2);
    for i = 1 : nImg
        [xlim(i,:), ylim(i,:)] = calcLimits(final_H{i}, size(imgs{i}));
    end
    avgXLim = mean(xlim, 2);
    [~, idx] = sort(avgXLim);
    centerIdx = floor((nImg + 1) / 2);
    centerImageIdx = idx(centerIdx);
    
    % re-calculate the homography, using centerImageIdx as the standard
    getFinalHomography(centerImageIdx);
    
    for i = 1 : nImg
        [xlim(i,:), ylim(i,:)] = calcLimits(final_H{i}, size(imgs{i}));
    end
    
    % coordinate
    ur = min(xlim(:, 1, 1)) : max(xlim(:, 1, 2));
    vr = min(ylim(:, 1, 1)) : max(ylim(:, 1, 2));
    [u,v] = meshgrid(ur,vr) ;
    
    % generate the transformed imgs
    imgs_{nImg} = {};
    adjust = 0;
    pano = 0;
    for i = 1 : nImg
        if E(centerImageIdx, i) == 1
            H_inv = H{centerImageIdx, i};
        else
            H_inv = inv(final_H{i});
        end
        z_ =  H_inv(3,1) * u + H_inv(3,2) * v + H_inv(3,3) ;
        u_ = (H_inv(1,1) * u + H_inv(1,2) * v + H_inv(1,3)) ./ z_ ;
        v_ = (H_inv(2,1) * u + H_inv(2,2) * v + H_inv(2,3)) ./ z_ ;
        imgs_{i} = interplotate(im2double(imgs{i}), u_, v_);
        adjust = adjust + ~isnan(imgs_{i});
        tmp = imgs_{i};
        tmp(isnan(tmp)) = 0;
        pano = pano + tmp;
    end
    pano(isnan(pano)) = 0;
    pano = pano ./ adjust;
end

% calulate the limit size of transformed images
function [xlim, ylim] = calcLimits(H, imgSize)
    bound = [   1   imgSize(2)  imgSize(2)  1 ;
                1   1           imgSize(1)  imgSize(1) ;
                1   1           1           1 ] ;
    bound_ = H * bound;
    bound_(1,:) = bound_(1,:) ./ bound_(3,:);
    bound_(2,:) = bound_(2,:) ./ bound_(3,:);
    xlim = [min(bound_(1,:)), max(bound_(1,:))];
    ylim = [min(bound_(2,:)), max(bound_(2,:))];
end