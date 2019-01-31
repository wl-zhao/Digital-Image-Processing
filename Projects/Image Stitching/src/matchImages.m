% Find matched images and return the transform matrix 
function [transMatrix, scores, matches] = matchImages(imgs, f, d)
    epsilon = 5;
    trialNum = 500;
    alpha = 8.0;
    beta = 0.3;
    N = numel(imgs);
    scores = zeros(N, N);
    transMatrix = cell(N, N);
    matches{N, N} = {};
    for i = 1 : N
        for j = i + 1 : N
           matches{i, j} =  matchDescriptor(f{i}, d{i}, f{j}, d{j});
           [H, matchedpoints] = RANSAC(matches{i, j}, trialNum, epsilon);
           ni = sum(matchedpoints);
           nf = size(matchedpoints, 2);
           if ni > alpha + beta * nf
               scores(i, j) = ni / nf;
               transMatrix{i, j} = H;
               transMatrix{j, i} = inv(H);
           end
        end
    end
end

function result = matchDescriptor(f1, d1, f2, d2)
    matches = vl_ubcmatch(d1, d2);
    matchesNum = size(matches, 2);
    result = zeros(3, matchesNum, 2);
    result(:, :, 1) = [f1(1 : 2, matches(1, :)); ones(1, matchesNum)];
    result(:, :, 2) = [f2(1 : 2, matches(2, :)); ones(1, matchesNum)];
end