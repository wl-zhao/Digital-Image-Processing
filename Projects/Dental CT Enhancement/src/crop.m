% crop image I according the range defined by roi
function c = crop(I, roi)
    roi = floor(roi);
    c = I(roi(3) : roi(4), roi(1) : roi(2));
end