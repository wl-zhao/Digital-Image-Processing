function adjusted = intensityAdjust(G, mask, lineMasks, offset, roi, gamma, draw)
    if offset == 0
        adjusted = G;
        return;
    end
    if nargin == 4 || (numel(roi) == 1 && roi == -1)
        roi = [1, size(G, 1), 1, size(G, 2)];
    end
    if nargin < 6
        gamma = false;
    end
    if nargin < 7
        draw = false;
    end
    mask = cropMask(mask, roi);
    
    % crop lineMasks to roi
    lineMasks{1} = cropMask(lineMasks{1}, roi);
    lineMasks{2} = cropMask(lineMasks{2}, roi);
    
    % get left and right side masks
    sm_left = sideMask(lineMasks{1}, 'left', offset);
    sm_right = sideMask(lineMasks{2}, 'right', offset);
    fixer_area = G .* mask;
    neighbor_area = G .* sm_left + G .* sm_right;
    
    % adjust intensity according to the intensity of side masks
    I_fixer = sum(fixer_area, [1, 2]) / sum(fixer_area > 0, [1, 2]);
    I_neighbor = sum(neighbor_area, [1, 2]) / sum(neighbor_area > 0, [1, 2]);
    
    % use gamma adjust or linear adjust
    if gamma
        adjusted = G .* (1 - mask) + G .^ (log(I_neighbor) / log(I_fixer)) .* mask;
    else
        adjusted = G .* (1 - mask) + G .* mask * I_neighbor / I_fixer;
    end
    
    if draw
        imwrite(mask, 'intensity_mask.jpg');
        imwrite(sm_left + sm_right, 'neighbor_mask.jpg');
    end
end

function outputMask = cropMask(mask, roi)
    outputMask = zeros(size(mask));
    outputMask(roi(1) : roi(2),  roi(3) : roi(4)) = mask(roi(1) : roi(2),  roi(3) : roi(4));
end