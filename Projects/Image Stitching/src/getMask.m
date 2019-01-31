% calculate mask for multiband_blending
function m = getMask(A, B, N)
    mA = ~isnan(A(:, :, 1));
    mB = ~isnan(B(:, :, 1));
    m = mA .* mB;
    s = size(A);
    % get edge
    h = fspecial('average', [5, 5]);
    A_nB = mA .* (1 - mB);
    A_nBf = imfilter(A_nB, h);
    edge1 = (A_nBf > 0) .* m;
    
    [x1, y1] = ind2sub(s, find(edge1 > 0)');
    value1 = ones(size(x1));
    
    B_nA = mB .* (1 - mA);
    B_nAf = imfilter(B_nA, h);
    edge2 = (B_nAf > 0) .* m;
    
    [x2, y2] = ind2sub(s, find(edge2 > 0)');
    value2 = zeros(size(x2));
    
    xy = [x1, x2;y1, y2];
    sel_ind = 1 : N : size(xy, 2);
    xy = xy(:, sel_ind);
    value = [value1, value2];
    value = value(sel_ind);
    st = tpaps(xy, value, 1);
    ind = find(m > 0)';
    [x, y] = ind2sub(s, ind);
    m(ind) = fnval(st, [x; y]);
end