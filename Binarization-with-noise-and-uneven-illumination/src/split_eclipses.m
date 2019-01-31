function [eclipses, area_num, total] = split_eclipses(I)
    eclipses{2} = {};
    [L, n] = bwlabel(I);
    i = 1;
    se = strel('sphere', 3);
    total = zeros(size(I));
    for j = 1 : n
        current_area = L == j;
        if (sum(current_area > 0, 'all') > 100)
            % close operation
            current_area = imdilate(current_area, se);
            current_area = imerode(current_area, se);
            eclipses{i} = current_area;
            total = total + current_area;
            i = i + 1;
        end
    end
    area_num = i - 1;
end