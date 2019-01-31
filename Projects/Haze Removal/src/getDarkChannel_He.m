function I_dark = getDarkChannel_He(I, batch_size)
    d = floor(batch_size / 2);
    Channel_min = min(I, [], 3);
    I_dark = ordfilt2(Channel_min, 1, ones(batch_size, batch_size), 'symmetric');
end