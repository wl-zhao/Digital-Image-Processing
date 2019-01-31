function outImg = reconstruct_eclipse(Img, iter, gifWriter)
    if nargin < 3
        gw = GIFWriter('', false);
    else
        gw = gifWriter;
    end
    % get edge
    se = strel('sphere', 1);
    eroded = imerode(Img, se);
    edge = Img - eroded;
    
    gw.addImage(Img, '待处理区域', 1);
    gw.addImage(edge, '边界提取', 1);
    
    [ys, xs] = find(edge > 0);
    num = numel(ys);
    last_b = nan(5, 1);
    last_diff = nan;
    if (iter)
        for i = 1 : 10 : num
            index = i : 10 : i + 5 * 10;
            try
                y = ys(index);
            catch
                break;
            end
            x = xs(index); 

            showPoints = insertShape(edge, 'FilledCircle', [x, y, 2 * ones(size(x))],'Opacity', 1);
            gw.addImage(showPoints, '选取边界点', 0.1);
            
            X = [x .^ 2, x .* y, x, y, ones(size(x))];
            Y = - y .^ 2;
            b = regress(Y, X);
            if (b(2) ^ 2 - 4 * b(1) < 0)
                diff = calc_diff(last_b, b, size(Img));
                if (all(~isnan(last_b)) && diff < 1)
                    if (~isnan(last_diff) && abs(last_diff - diff) < 0.5)
                        b = last_b;
                        gw.addImage(showPoints, '选取结束', 1);
                        break;
                    end       
                    last_diff = diff;
                end
                last_b = b;
            end
        end
    else
        index = 1 : 10 : num;
        y = ys(index);
        x = xs(index); 
        showPoints = insertShape(edge, 'FilledCircle', [x, y, 2 * ones(size(x))], 'Opacity', 1);
        gw.addImage(showPoints, '选取边界点', 1);
        X = [x .^ 2, x .* y, x, y, ones(size(x))];
        Y = - y .^ 2;
        b = regress(Y, X);
    end
    
    f = @(x, y)(b(1) * x .^ 2 + b(2) * x .* y + y .^ 2 + b(3) * x + b(4) * y + b(5));
    outImg = zeros(size(Img));
    for x = 1 : size(outImg, 2)
        for y = 1 : size(outImg, 1)
            if (f(x, y) <= 0)
                outImg(y, x) = 1;
            else
                outImg(y, x) = 0;
            end
        end
    end
    
    gw.addImage(outImg, '重构结果', 2);

end