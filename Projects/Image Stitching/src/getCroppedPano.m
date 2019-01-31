% crop the panorama
function crop_pano = getCroppedPano(pano)
    row1 = floor(size(pano, 1) / 2);
    row2 = floor(size(pano, 1) / 2) + 1;
    while(row1 >= 1 && row2 <= size(pano, 1))
        if calc_area(row1, row2, pano) <= calc_area(row1 - 1, row2, pano)
            row1 = row1 - 1;
        elseif calc_area(row1, row2, pano) <= calc_area(row1, row2 + 1, pano)
            row2 = row2 + 1;
        else
            break;
        end
    end
    crop_pano = pano(row1 : row2, ~isnan(pano(row1, :, 1)) .* ~isnan(pano(row2, :, 1)) == 1, :);
end
    
function A = calc_area(row1, row2, pano)
    A = sum(~isnan(pano(row1, :, 1)) .* ~isnan(pano(row2, :, 1))) * (row2 - row1);
end
