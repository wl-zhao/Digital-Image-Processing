function F = deblur(G, radius, smooth, dering)
    if size(G, 3) == 3
        F = G;
        for c = 1 : 3
            F(:, :, c) = deblur(G(:, :, c), radius, smooth, dering);
        end
    else
        % generate psf
        psf = zeros(size(G, 1), size(G, 2));
        [rows, cols] = size(psf);
        psf = insertShape(psf, 'FilledCircle', [(cols + 1)/ 2, (rows + 1)/ 2, radius], 'Color', 'white', 'Opacity', 1) * 255;      
        psf = psf(:, :, 1);
        psf = psf ./ sum(sum(psf));
        psf = fftshift(psf);
        
        psf_fft = fft2(psf);
        G_fft = fft2(G);
        % process the image to prevent ring effect
        if strcmp(dering, 'On')
            for i = 1 : rows
                for j = 1 : cols
                    G_fft(i, j) = G_fft(i, j) * real(psf_fft(i, j));
                end
            end

            tmp = real(ifft2(G_fft));
            for i = 1 : rows
                for j = 1 : cols
                    if (i < radius) || (j < radius) || (i > rows - radius) || (j > cols - radius)
                        G(i, j) = tmp(i, j);% / (rows * cols);
                    end
                end
            end
        end
        % wiener inverse filter
        G_fft= fft2(G);
        K = (1.09 ^ smooth) / 10000;
        for i = 1 : rows
            for j = 1 : cols
                energyValue = abs(psf_fft(i, j)) ^ 2;
                wienerValue = real(psf_fft(i, j)) / (energyValue + K);
                G_fft(i, j) = wienerValue * G_fft(i, j);
            end
        end
        F = uint8(real(ifft2(G_fft)));
    end
end