function [] = scale_scan(U, test_img)

    [h, w] = size(test_img);

    test_0_5  = imresize(test_img,[0.5*h, 0.5*w]);
    test_0_75 =imresize(test_img,[0.75*h, 0.75*w]);
    test_1_5 =imresize(test_img,[1.5*h, 1.5*w]);
    test_2 =imresize(test_img,[2*h, 2*w]);

    scan_original = scan(U(:, 1), test_img);
    orignal_loc = get_locations(scan_original);

    scan_0_5 = scan(U(:, 1), test_0_5);
    loc_0_5 = get_locations(scan_original);
    
    scan_0_75 = scan(U(:, 1), test_0_75);
    loc_0_7 = get_locations(scan_0_75);

    scan_1_5 = scan(U(:, 1), test_1_5);
    loc_1_5 = get_locations(scan_1_5);

    scan_2 = scan(U(:, 1), test_2);
    loc_2 = get_locations(scan_2);
    
    x = 5;

end