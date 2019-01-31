% universial method to get mask
function mask = getMask(G, x, show)
    if nargin == 2
        show = false;
    end
    if length(x) == 1
        mask = insertShape(zeros(size(G)), 'Line', [x, 1, x, size(G, 1)], 'Color', 'White', 'Opacity', 1, 'LineWidth', 1);
    elseif length(x) == 2
        mask = insertShape(zeros(size(G)), 'FilledPolygon', [x(1, 1), x(1, 2), x(1, 1), x(2, 2), x(2, 1), x(2, 2), x(2, 1), x(1, 2)], 'Color', 'White', 'Opacity', 1);
    elseif length(x) == 4
        mask = insertShape(zeros(size(G)), 'Line', x, 'Color', 'White', 'Opacity', 1, 'LineWidth', 1);
    elseif length(x) == 8
        mask = insertShape(zeros(size(G)), 'FilledPolygon', x, 'Color', 'White', 'Opacity', 1);
    end
    mask = mask(:, :, 1);
    if nargin == 3 && show == true
        imshow(mask);
    end
end