classdef GIFWriter < handle
    properties
        filename
        fig
        im
        nImages
        delay
        writeGIF
    end
    methods
        function init(obj, fn, writeGIF)
            obj.writeGIF = writeGIF;
            if ~writeGIF
                return;
            end
            obj.fig = figure('visible', 'off');
            obj.nImages = 0;
            obj.filename = fn;
            obj.im{1} = 1;
            obj.delay{1} = 1;
        end
        
        function addImage(obj, I, t, delay)
            if ~obj.writeGIF
                return;
            end
            obj.nImages = obj.nImages + 1;
            imshow(I);
            title(t);
            drawnow;
            frame = getframe(obj.fig);
            obj.im{obj.nImages} = frame2im(frame);
            obj.delay{obj.nImages} = delay;
        end
        
        function write(obj)
            if ~obj.writeGIF
                return;
            end
            for idx = 1 : obj.nImages
                [A, map] = rgb2ind(obj.im{idx},256);
                if idx == 1
                    imwrite(A, map,obj.filename,'gif','LoopCount',Inf,'DelayTime',obj.delay{idx});
                else
                    imwrite(A, map, obj.filename,'gif','WriteMode','append','DelayTime',obj.delay{idx});
                end
            end
        end
    end
end