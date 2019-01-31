% remove all the fixers
function J = removeFixers(I, lineMasks, offset, threshold)
    J = I;
    for u = 1 : 3
        for v = 1 : 2 
            J = removeFixer(J, lineMasks{u}{v}, offset(u, v), -1);
            J = removeFixer(J, lineMasks{u}{v}, 30, threshold(u, v));
        end
    end
end