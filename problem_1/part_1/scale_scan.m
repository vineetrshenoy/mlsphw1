function [loc] = scale_scan(U, test_img, k_clusters, max_k)

    [h, w] = size(test_img);

    test_0_5  = imresize(test_img,[0.5*h, 0.5*w]);
    test_0_75 =imresize(test_img,[0.75*h, 0.75*w]);
    test_1_5 =imresize(test_img,[1.5*h, 1.5*w]);
    test_2 =imresize(test_img,[2*h, 2*w]);

    scan_original = scan(U(:, 1), test_img);
    original_loc = get_locations(scan_original, k_clusters, max_k);
    original_loc(:, 4) = ones(k_clusters, 1);

    scan_0_5 = scan(U(:, 1), test_0_5);
    loc_0_5 = get_locations(scan_original, k_clusters, max_k);
    loc_0_5(:, 1:2) = loc_0_5(:, 1:2) * 2;
    loc_0_5(:, 4) = ones(k_clusters, 1) * 2;
    
    scan_0_75 = scan(U(:, 1), test_0_75);
    loc_0_7 = get_locations(scan_0_75, k_clusters, max_k);
    loc_0_7(:, 1:2) = loc_0_7(:, 1:2) * (4/3);
    loc_0_7(:, 4) = ones(k_clusters, 1) * (4/3);

    scan_1_5 = scan(U(:, 1), test_1_5);
    loc_1_5 = get_locations(scan_1_5, k_clusters, max_k);
    loc_1_5(:, 1:2) = loc_1_5(:, 1:2) * (2/3);
    loc_1_5(:, 4) = ones(k_clusters, 1) * (2/3);

    scan_2 = scan(U(:, 1), test_2);
    loc_2 = get_locations(scan_2, k_clusters, max_k);
    loc_2(:, 1:2) = loc_2(:, 1:2) * (1/2);
    loc_2(:, 4) = ones(k_clusters, 1) * (1/2);
    
    
    all_loc = [original_loc; loc_0_5; loc_0_7; loc_1_5; loc_2];

    [max_val, face_idx] = maxk(all_loc(:, 3), k_clusters);
    
    loc = all_loc(face_idx, :);
    loc = loc_0_7;

end