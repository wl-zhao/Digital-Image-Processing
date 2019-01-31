function [A, canvas] = getA_Kim(I)
    canvas = I;
    [m, n, ~] = size(I);
    region = I;
    bound =  [1, size(I, 1), 1, size(I, 2)];
    while(1)
        mid_row = floor(size(region, 1) / 2);
        if (mid_row < min(m, n) / 8)
            break;
        end
        mid_col = floor(size(region, 2) / 2);
        subRegions{4} = {};
        % 1 3
        % 2 4
        subRegions{1} = region(1 : mid_row, 1 : mid_col, :);
        subRegions{2} = region(mid_row + 1 : end, 1 : mid_col, :);
        subRegions{3} = region(1 : mid_row, mid_col + 1 : end, :);
        subRegions{4} = region(mid_row + 1 : end, mid_col + 1 : end, :);
        score = zeros(1, 4);
        for k = 1 : 4
            R = subRegions{k}(:, :, 1);
            G = subRegions{k}(:, :, 2);
            B = subRegions{k}(:, :, 3);            
            scoreR = mean(R(:)) - std(R(:));
            scoreG = mean(G(:)) - std(G(:));
            scoreB = mean(B(:)) - std(B(:));    
            score(k) = scoreR + scoreG + scoreB;
        end
        [~, ind] = max(score);
        region = subRegions{ind};
        mid_row_index = floor((bound(1) + bound(2)) / 2);
        mid_col_index = floor((bound(3) + bound(4)) / 2);
        canvas = insertShape(canvas, 'Line', [mid_col_index, bound(1), mid_col_index, bound(2)], 'Color', 'red', 'Opacity', 1, 'LineWidth', 3);
        canvas = insertShape(canvas, 'Line', [bound(3), mid_row_index, bound(4), mid_row_index], 'Color', 'red', 'Opacity', 1, 'LineWidth', 3);
        switch ind
            case 1
                bound(2) = mid_row_index;
                bound(4) = mid_col_index;
            case 2
                bound(1) = mid_row_index;
                bound(4) = mid_col_index;
            case 3
                bound(2) = mid_row_index;
                bound(3) = mid_col_index;
            case 4
                bound(1) = mid_row_index;
                bound(3) = mid_col_index;
        end
    end
    canvas = insertShape(canvas, 'FilledRectangle', [bound(3), bound(1), bound(4) - bound(3), bound(2) - bound(1)], 'Color', 'Red');
    % choose the color vector
    distance = vecnorm(region - 1, 2, 3);
    [~, p] = min(distance(:));
    [mm, nn, ~] = size(region);
    [i, j] = ind2sub([mm, nn], p);
    A = region(i, j, :);
    A = repmat(A, m, n);
end