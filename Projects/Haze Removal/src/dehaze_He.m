function [J, tilde_t, t, I_dark] = dehaze_He(I, gamma)
    % Single Image Haze Removal Using Dark Channel Prior, He et al. 
    % Use Guided Filter instead of Laplacian matrix in soft matting
 
    if nargin < 2
        gamma = 0.6;
    end
    % Get Dark Channel
    I_dark = getDarkChannel_He(I, 5);
    
    % Get A
    A = getA_He(I, I_dark, 0.001);
    
    % Estimating the Transmission
    omega = 0.95;
    tilde_t = 1 - omega * double(I_dark) ./ A;
    
    % Guided filter
    s = floor(min(size(I, 1), size(I, 2)) / 16);
    r = 4 * s;
    t = fastguidedfilter_color(I, tilde_t(:, :, 1), r, 0.001, s);
    
    % final results
    J = (I - A) ./ max(t, 0.1) + A;
    J(J > 1) = 1;
    J(J < 0) = 0;
    J = J .^ gamma;
end