function bw = ostu_binarize(Img)
    if (size(Img, 3) == 3)
        Img = rgb2gray(Img);
    end
    
    [hist, i] = imhist(Img);
    pi = hist / numel(Img);
    P1 = cumsum(pi);
    m = cumsum(i .* pi);
    m_G = mean(Img, [1, 2]);
    sigma_B_square = (m_G * P1 - m) .^ 2 ./ (P1 .* (1 - P1));
    [~, k_star] = max(sigma_B_square);
    bw = 255 * (Img > (k_star - 1));
end