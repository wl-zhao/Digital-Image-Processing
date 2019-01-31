function outputImg = removeSpine(I, D0, gamma, a)
    if nargin < 3
        gamma = 0.8;
        a = 1.1;
    elseif nargin < 4
        a = 1.1;
    end
    % high pass filter
    roi =  [500, 1; 2600, size(I, 1)];
    I_crop = crop(I, roi);
    
    I_fft = fftshift(fft2(I_crop));
    H = zeros(size(I_fft));
    [m, n] = size(H);
    order = 2;
    for u = 1 : m
        for v = 1 : n
            D = sqrt((u - (m + 1) / 2) ^ 2 + (v - (n + 1) / 2) ^ 2);
            H(u, v) = 1 - 1 /(1 + (sqrt(2) -  1) * (D / D0) ^ (2 * order));
        end
    end
  
    I_fft = I_fft .* H;
    I_crop = real(ifft2(ifftshift(I_fft)));
    I_crop = (I_crop - min(min(I_crop)))./ (max(max(I_crop)) - min(min(I_crop))) * (max(max(I)) - min(min(I)) + min(min(I)));
    J = I;
    J(roi(3) : roi(4), roi(1) : roi(2)) = I_crop  .^ gamma * a;    
    % blend
    sigma = 300;
    x = 1 : size(I, 2);
    d = 500;
    c = 1547;
    mask1 = meshgrid(gaussmf(x, [sigma, c - d / 2]), 1 : size(I, 1));
    mask2 = meshgrid(gaussmf(x, [sigma, c + d / 2]), 1 : size(I, 1));
    mask1(:, c - d / 2 : end) = 0;
    mask2(:,1 : c + d / 2) = 0;
    mask = mask1 + mask2;
    mask(:, c - d / 2: c + d / 2) = 1;
    mask(mask > 1) = 1;
    outputImg = J .* mask + I .* (1 - mask);
end