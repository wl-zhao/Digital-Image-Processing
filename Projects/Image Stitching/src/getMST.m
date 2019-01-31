% get minimum spanning tree
function [connected, E] = getMST(scores)
    N = size(scores, 1);
    E = zeros(N);
    F = 1;
    Q = 2 : N;
    times = 0;
    while times < N - 1
        times = times + 1;
        temp = scores(F, Q);
        max_score = max(temp(:));
        if max_score == 0
            continue;
        end
        [u_idx, v_idx] = find(scores(F, Q)==max_score);
        u = F(u_idx(1)); v = Q(v_idx(1));
        F = [F, v]; Q(Q==v) = [];
        E(u, v) = 1; E(v, u) = 1;
    end
    
    connected = 1;
    if length(F) < N
        connected = 0;
    end
end