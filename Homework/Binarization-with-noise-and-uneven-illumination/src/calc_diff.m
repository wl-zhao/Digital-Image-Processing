function diff = calc_diff(b1, b2, sz)
    d = b1 - b2;
    % x
    d(3) = d(3) / sz(1);
    %y
    d(4) = d(4) / sz(2);
    %constant
    d(5) = d(5) / (sz(1) * sz(2));
    diff = norm(d);
end