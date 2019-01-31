function radius = estimateRadius(g, doPlot)
    g = im2double(g);
    if size(g, 3) == 3
        g = rgb2gray(g);
    end
    h = fspecial('laplacian', 0);
    lg = imfilter(g, h, 'circular');
    LG = fft2(lg);
    R = conj(LG) .* LG;
    r = abs(real(ifft2(R)));
    [~, idx1] = min(r(ceil((end + 1) / 2): ceil((end + 1) / 2) + 15, ceil((end + 1) / 2)));
    [~, idx2] = min(r(ceil((end + 1) / 2): -1 :ceil((end + 1) / 2) - 15, ceil((end + 1) / 2)));
    if doPlot
        plot(r(ceil((end + 1) / 2) - 15 : ceil((end + 1) / 2) + 15, ceil((end + 1) / 2)));
        grid on;
        hold on;
        x1 = idx1;
        x2 = idx2;
        plot(15 + x1, r(x1 + ceil((end + 1) / 2) - 1, ceil((end + 1) / 2)), 'ro');
        plot(17 - x2, r(ceil((end + 1) / 2) - x2 + 1, ceil((end + 1) / 2)), 'ro');
        xlabel('$y$', 'interpreter', 'latex');
        ylabel('$r$', 'interpreter', 'latex');
        
        axis tight;
        hold off;
    end

    radius = abs((idx2 - 1) + (idx1 - 1)) / 2;
end