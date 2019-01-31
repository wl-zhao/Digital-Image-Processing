% matches: matches frame from matchDescriptor
% trialNum, loop times
% epsilon, tolerant
function [H, matchedFrames] = RANSAC(matches, trialNum, epsilon)
    X1 = matches(:, :, 1);
    X2 = matches(:, :, 2);
    matchedFrames{trialNum} = {};
    H{trialNum} = {};
    score = zeros(trialNum, 1);
    for t = 1 : trialNum
        % estimate homograpyh
        rand_sub = vl_colsubset(1 : size(X1, 2), 4);
        A = [];
        for i = rand_sub
            A = cat(1, A, kron(X1(:, i)', vl_hat(X2(:, i))));
        end
        [~, ~, V] = svd(A);
        H{t} = reshape(V(:, 9), 3, 3);
        
        % score
        X2_ = H{t} * X1;
        du = X2_(1,:)./X2_(3,:) - X2(1,:)./X2(3,:);
        dv = X2_(2,:)./X2_(3,:) - X2(2,:)./X2(3,:);
        matchedFrames{t} = (du .* du + dv .* dv) < epsilon * epsilon ;
        score(t) = sum(matchedFrames{t});
    end
    [~, best] = max(score);
    H = H{best};
    matchedFrames = matchedFrames{best};
end