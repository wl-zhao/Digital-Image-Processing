function Vd = fastNLMp(V, ds, Ds, h)
    % ds : half length of patch to compare
    % Ds : half size of search window 
    % h : deviation of the gaussian
    if size(V, 3) == 3
        Vd = V;
        Vd(:, :, 1) = fastNLMp(V(:, :, 1), ds, Ds, h);     
        Vd(:, :, 2) = fastNLMp(V(:, :, 2), ds, Ds, h);   
        Vd(:, :, 3) = fastNLMp(V(:, :, 3), ds, Ds, h);
        return;
    end
    V = double(V);
    % padding
    Vsym = padarray(V, [Ds + ds, Ds + ds], 'symmetric');
    d = 2 * ds + 1; d2 = d * d;
    h2 = h * h;
    % sum weight, output image
    SW = 0; Vd = 0;
    % traverse the offset
    for t1 = - Ds : Ds
        for t2 = - Ds : Ds
            Vsym_y = Vsym(1 + Ds + ds + t1 : end - Ds - ds + t1, 1 + Ds + ds + t2 : end - Ds - ds + t2);
            II = IntegralImage(Vsym, Ds, t1, t2);
            Dist2 = II(1 : end - 2 * ds, 1 : end - 2 * ds) + II(1 + 2 * ds: end, 1 + 2 * ds : end) - ...
                II(1 : end - 2 * ds, 1 + 2 * ds : end) - II(1 + 2 * ds: end, 1 : end - 2 * ds);
            Dist2 = Dist2 / d2;
            W = exp(- Dist2 / h2);
            SW = SW + W;
            Vd = Vd + W .* Vsym_y;
        end
    end
    Vd = min(max(Vd ./ SW, 0), 255);
    Vd = uint8(Vd);
end

% get integral image
function II = IntegralImage(Vsym, Ds, t1, t2)
    Dist2 = (Vsym(1 + Ds : end - Ds, 1 + Ds : end - Ds) - ...
        Vsym(1 + Ds + t1 : end - Ds + t1, 1 + Ds + t2 : end - Ds + t2)) .^ 2;
    II = cumsum(Dist2, 1);
    II = cumsum(II, 2);
end
