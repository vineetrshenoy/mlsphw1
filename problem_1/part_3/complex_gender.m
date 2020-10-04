function [accuracy classifier] = complex_gender(U, k, train_data, test_data)

    proj_mat = U(:, 1:k) ./ vecnorm(U(:, 1:k));

    [r_train, c_train] = size(train_data);
    [r_test, c_test] = size(test_data);

    train_weights = zeros(k, c_train);
    for i=1:c_train
        [vec, weight] = project(proj_mat, train_data(:, i));
        train_weights(:, i) = weight;
    end

    test_weights = zeros(k, c_test);
    for i=1:c_test
        [vec, weight] = project(proj_mat, test_data(:, i));
        test_weights(:, i) = weight;
    end
    

    ground_truth = ones(1, c_test);
    ground_truth(1:(c_test/2)) = zeros(1, (c_test/2));

    classifier = zeros(1, c_test);
    %Calculating the accuracy
    for i=1:c_test

        test_w = test_weights(:, i);
        difference = train_weights - test_w;
        score = vecnorm(difference);

        score_men = sum(score(1:(c_test/2)));
        score_women = sum(score((c_test/2) + 1:end));

        if female_diff < male_diff 

            classifier(i) = 1;
        
        else
            classifier(i) = 0;

        end

    end

    difference = ground_truth - classifier;

    accuracy = (c - nnz(difference)) / c;


end