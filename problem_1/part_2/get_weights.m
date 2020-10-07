function [data, labels] = get_weights(direc1, direc2, U, k)

    boost_face = load_boosting_data(direc1);
    weight_face = pinv(U(:, 1:k)) * boost_face;
    [rf, cf] = size(weight_face);


    %A =  U(:, 1:k) * weight(:, 1);
    boost_noface = load_boosting_data(direc2);
    weight_noface = pinv(U(:, 1:k)) * boost_noface;
    [rnf, cnf] = size(weight_noface);


    data = [weight_face, weight_noface];
    labels = zeros(1, cf + cnf);

    labels(1:cf) = ones(1, cf);

end
