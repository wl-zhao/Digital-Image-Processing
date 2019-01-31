function best_t = estimateTBlock_Kim(Block, A, lambda)
    best_t = nan;
    min_E = nan;
    for t = 0.1 : 0.1 : 1
        E_loss = 0;
        out = (Block - A) / t + A; % out from block
        E_loss = E_loss + (out > 1) .* (out - 1) .^ 2;
        E_loss = E_loss + (out < 0) .* out .^ 2;
        E_loss = sum(E_loss, 'all');
        
        E_contrast = 0;
        for c = 1 : 3
            E_contrast = E_contrast - std(Block(:, :, c), 1, 'all');
        end
        E = E_contrast + lambda * E_loss;
        if (t == 0.1) || (min_E > E)
            best_t = t;
            min_E = E;
        end
    end
end