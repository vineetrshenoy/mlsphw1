function [] = scale_scan(U, test_img)

    
    test_32  = imresize(test_img,[32, 32]);
    test_48 =imresize(test_img,[48,48]);
    test_96 =imresize(test_img,[96, 96]);
    test_128 =imresize(test_img,[128, 128]);

    scan_original = scan(U(:, 1), test_img);
    scan_32 = scan(U(:, 1), test_32);
    scan_48 = scan(U(:, 1), test_48);
    scan_96 = scan(U(:, 1), test_96);
    scan_128 = scan(U(:, 1), test_128);
    


end