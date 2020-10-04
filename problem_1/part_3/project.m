function [vec, weights] = project(proj_mat, data_vec)

    [r, c] = size(proj_mat);
    vec = zeros(r, 1);

    weights = zeros(1, c);
    %data_vec = reshape(data_vec, [], 1);
    for i = 1:c

        weights(i) = (proj_mat(:, i)' * double(data_vec));
        vec = vec +  weights(i)* proj_mat(:, i);
    end

end