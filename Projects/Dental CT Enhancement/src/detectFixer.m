% detect a fixer
function [fixer, mask, lineMasks] = detectFixer(Img, roi, thresh, sigma, draw, show)
    if nargin < 6
        show = false;
    end
    % crop
    I = Img(roi(1) : roi(2), roi(3) : roi(4));
    BW = edge(I, 'canny', thresh, sigma);

    [H, theta, rho]= hough(BW, 'RhoResolution', 0.5, 'ThetaResolution', 0.5);  
    peak = houghpeaks(H, 2); 
    lines = houghlines(BW, theta, rho, peak, 'MinLength', 10); 
    
    % show hough result
    if show
        figure();
        colormap(gca, hot);
        imshow(imadjust(rescale(H)),'XData',theta,'YData',rho,...
      'InitialMagnification','fit');
        xlabel('\theta'), ylabel('\rho');
        axis on, axis normal, hold on;
    end
    
    % adjust the slope of lines
    fixer = lines;
    if lines(1).theta ~= lines(2).theta
        tmp_p = (lines(1).point1 + lines(1).point2) / 2;
        delta_p = (lines(1).point2 - lines(2).point1) / 2;
        lines(1).point1 = tmp_p;
        lines(1).point2 = tmp_p + (lines(2).point2 - lines(2).point1) / (lines(2).point2(2) - lines(2).point1(2)) * delta_p(2);
    end
    
    for i = 1 : length(lines)
        p1 = lines(i).point1 + [roi(3) -  1, roi(1) - 1];
        p2 = lines(i).point2 + [roi(3) -  1, roi(1) - 1];
        fixer(i).point1 = (p1 - p2) / (p1(2) - p2(2)) * (1 - p2(2)) + p2;
        fixer(i).point2 = (p1 - p2) / (p1(2) - p2(2)) * (size(Img, 1) - p2(2)) + p2;    
    end
    
    % ensure fixer(1) is the left bound
    mid1 = (fixer(1).point1 + fixer(1).point2) / 2;
    mid2 = (fixer(2).point1 + fixer(2).point2) / 2;
    if mid1(1) > mid2(1)
        tmp = fixer(1);
        fixer(1) = fixer(2);
        fixer(2) = tmp;
    end
    
    % mask denotes the fixer area
    canvas = zeros(size(Img));
    mask = insertShape(canvas, 'FilledPolygon', ...
    [fixer(1).point1 fixer(1).point2 fixer(2).point2 fixer(2).point1],...
    'Color', 'White', 'Opacity', 1, 'LineWidth', 10);%, 'SmoothEdges', false); 
    mask = mask(:, :, 1);
    
    % lineMasks denote the fixer bounds
    lineMasks{1} = zeros(size(Img));
    lineMasks{2} = zeros(size(Img));
    lineMasks{1} = insertShape(canvas, 'Line', [fixer(1).point1 fixer(1).point2],...
        'Color', 'White', 'Opacity', 1, 'LineWidth', 1, 'SmoothEdges', false);
    lineMasks{2} = insertShape(canvas, 'Line', [fixer(2).point1 fixer(2).point2],...
        'Color', 'White', 'Opacity', 1, 'LineWidth', 1, 'SmoothEdges', false);
    lineMasks{1} = lineMasks{1}(:, :, 1);
    lineMasks{2} = lineMasks{2}(:, :, 1);
    
    if (show)
        figure();
        imshow(Img);
        hold on;
        for i = 1 : length(fixer)    
            xy=[fixer(i).point1; fixer(i).point2];    
            plot(xy(:,1), xy(:,2), 'LineWidth', 1);    
        end
        hold off;
    end
    
    if (draw)
        imwrite(I, 'roi.jpg');
        imwrite(BW, 'bw.jpg');
        f = BW;
        colors = {'Yellow', 'cyan'};
        for k=1:length(lines)
            f = insertShape(double(f), 'Line', [lines(k).point1, lines(k).point2], 'Color', colors{k}, 'Opacity', 1, 'LineWidth', 3);
        end
        imwrite(f, 'draw.jpg');
    end
end