function [normdot] = scan(E, test_img)

    N = 64;
    M = 64;
    [P, Q] = size(test_img);
    normdot = zeros((P - N), (Q - M));

    E = E / norm(E(:));
    for i = 1:(P - N)
        for j = 1:(Q - M)
            patch = test_img(i:i+N-1, j:j+M-1);
            normdot(i, j) = E(:)'*patch(:) / norm(patch(:));
        end
    end

end
