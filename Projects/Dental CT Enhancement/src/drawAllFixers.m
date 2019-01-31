function G = drawAllFixers(G, fixers, show)
    if show
        imshow(G);
        hold on;
        for k = 1 : numel(fixers)
            for i = 1 : length(fixers{k})
                xy=[fixers{k}(i).point1; fixers{k}(i).point2];
                plot(xy(:,1), xy(:,2), 'LineWidth', 1);
                hold on;
            end
        end
        hold off;
    else
        color = {'red', 'green', 'yellow'};
        for k = 1 : numel(fixers)
            for i = 1 : length(fixers{k})
                G = insertShape(G, 'Line', [fixers{k}(i).point1 fixers{k}(i).point2], 'Color', color{k}, 'Opacity', 1, 'LineWidth', 5);
            end
        end
    end
end