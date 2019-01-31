function outputImg = autoAdjust(img)
    max_edges = 0;
    h = fspecial('average', 3);
    for gamma = 0 : 0.1 : 2
        tmp = gammaAdjust(img, gamma);
        Omega = edgeDetection(tmp, 5, 1, [0.1 0.2]);
        Omega = (imfilter(Omega, h) > 0.3) .* Omega;
        n = get_connected_domain(Omega, 8);
        if max_edges < n
            max_edges = n;
            best_gamma = gamma;
        end
    end
    outputImg = gammaAdjust(img, best_gamma);
end