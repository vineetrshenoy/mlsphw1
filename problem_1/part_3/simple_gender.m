function [accuracy classifier] = simple_gender(U, k, mmean, wmean, test_data)

    proj_mat = U(:, 1:k) ./ vecnorm(U(:, 1:k));
    
    [male_proj, mweights] = project(proj_mat, mmean);
    [female_proj, fweights] = project(proj_mat, wmean);
    

    [r, c] = size(test_data);

    ground_truth = ones(1, c);
    ground_truth(1:(c/2)) = zeros(1, (c/2));

    classifier = zeros(1, c);
    for i=1:c

        [vec, weights] = project(proj_mat, test_data(:, i));

        male_diff = norm(mweights - weights);
        female_diff = norm(fweights - weights);
        
        if female_diff < male_diff 

            classifier(i) = 1;
        
        else
            classifier(i) = 0;

        end

    end


    difference = ground_truth - classifier;

    accuracy = (c - nnz(difference)) / c;

end