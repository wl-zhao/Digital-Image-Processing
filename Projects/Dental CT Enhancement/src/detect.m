% detect all the fixers
function [fixers, masks, lineMasks] = detect(G)
    [fixers{1}, masks{1}, lineMasks{1}] = detectFixer(G, [1100, 1130, 701, 1000], [0.3, 0.6], 5, false);
    [fixers{2}, masks{2}, lineMasks{2}] = detectFixer(G, [841, 947, 1427, 1675], [0.4, 0.8], 3, false);
    [fixers{3}, masks{3}, lineMasks{3}] = detectFixer(G, [1079, 1124, 2061, 2309], [0.4, 0.8], 3, false);
end