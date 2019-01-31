function S = multiband_blend(A, B, nImg)
    S = zeros(size(A), 'like', A);
    levels = 3;
    % A and B are images to be blended
    % R is the region image which decides the overlap area
    A1 = A(:, :, 1);
    B1 = B(:, :, 1);
    A_nB = ~isnan(A1) .* isnan(B1);
    B_nA = ~isnan(B1) .* isnan(A1);
    nA_nB = isnan(A1) .* isnan(B1);
    
    O = ~isnan(A1) .* ~isnan(B1);
    M = getMask(A, B, max([ceil(500 / nImg), 50]));
    M(A_nB == 1) = 1;
    M(B_nA == 1) = 0;

    A(isnan(A)) = 0;
    B(isnan(B)) = 0;
    I_A = mean(rgb2gray(A .* O), [1, 2]);
    I_B = mean(rgb2gray(B .* O), [1, 2]);
    B = B * (I_A / I_B);
    
    % build LA and LB
    LA = pyramid(A, levels, [5, 5], 'laplacian', 1);
    LB = pyramid(B, levels, [5, 5], 'laplacian', 1);
    kernel = fspecial('gaussian', [5, 5], 1);

    % build combined pyramid LS
    LS{levels, 3} = {};
    for L = 1 : levels
        LS{L} = M .* LA{L} + (1 - M) .* LB{L};
        M = imfilter(M, kernel);
        M = M(2 : 2:size(M, 1), 2 : 2 : size(M, 2));
        S = S + imresize(LS{L}, size(A(:, :, 1)));
    end
    S(nA_nB == 1) = nan;
end