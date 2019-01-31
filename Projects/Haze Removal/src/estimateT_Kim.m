function t = estimateT_Kim(I, A, block_size, lambda)
    [m, n, ~] = size(I);
    t = zeros(m, n);
    for row = 1 : block_size : m
        row_end = row + block_size - 1;
        if row_end > m
            row_end = m;
        end
        for col = 1 : block_size : n
            col_end = col + block_size - 1;
            if col_end > n
                col_end = n;
            end
            t(row : row_end, col : col_end) = estimateTBlock_Kim(I(row : row_end, col : col_end, :),... 
            A(row : row_end, col : col_end, :), lambda);
        end
    end
end