% generate a sidemask according to the lineMask and direction
function mask = sideMask(lineMask, direction, offset)
    mask = zeros(size(lineMask));
    if strcmp(direction, 'left')
        factor = -1;
    else
        factor = 1;
    end
    index = find(lineMask == 1);
    for i = 1 : offset
        try
            mask(i * size(lineMask, 1) * factor + index) = 1;
        catch
            break;
        end
    end
end