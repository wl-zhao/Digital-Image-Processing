function [A] = getA_He(I, I_dark, alpha)
    [m, n, ~] = size(I);
    I_gray = rgb2gray(I);
    num_pixels = floor(alpha * numel(I));
    [~, indices] = sort(I_dark(:), 'descend');
    max_intensity = -1;
    A = [0, 0, 0];
    for p = 1 : num_pixels
        index = indices(p);
        [i, j] = ind2sub([m, n], index);
        if (I_gray(i, j, 1) > max_intensity)
            A = I(i, j, :);
        end
    end
    A = repmat(reshape(A, 1, 1, 3), m, n);
end