% calculate the final homography from root
function getFinalHomography(root)
    global final_H;
    global E;
    global H;

    N = size(E, 1);
    for i = 1 : N
        if E(root, i) == 1 % new child
            final_H{i} = final_H{root} * H{i, root};
            E(root, i) = 0; E(i, root) = 0;
            getFinalHomography(i);
        end
    end
end