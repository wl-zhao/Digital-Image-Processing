function [J, tilde_t, t, canvas] = dehaze_Kim(I, gamma)
    % Optimized contrast enhancement for real-time image and video
    % dehazing, Kim et al.

    if nargin < 2
        gamma = 0.8;
    end
    s = floor(min(size(I, 1), size(I, 2)) / 16);
    r = 4 * s;
    % get atmosphere
    [A, canvas] = getA_Kim(I);

    % estimate t
    tilde_t = estimateT_Kim(I, A, 32, 1);

    % guided filter to refine t
    t = fastguidedfilter_color(I, tilde_t, r, 0.001, s);

    % get result
    J = (I - A) ./ max(t, 0.1) + A;
    J(J > 1) = 1;
    J(J < 0) = 0;
    J = J .^ gamma;
end