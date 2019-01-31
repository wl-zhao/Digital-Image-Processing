function pix = using_lib_count(L, N)
    pix = zeros(1, N);
    for i = 1 : N
        pix(i) = sum(sum(L == i * ones(size(L))));
    end
    pix = sort(pix);
end