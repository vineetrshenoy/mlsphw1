function [] = draw(img, boxes)
    
    N = 64;
    M = 64;
    [r, c] = size(boxes);

    imshow(img, []);
    

    for i = 1:r
        bbox = [boxes(i, 2) boxes(i, 1) N*boxes(i, 4) M*boxes(i, 4)];
        %bbox = [1, 300, 64, 64];
        rectangle('Position', bbox, 'EdgeColor', 'r')
    end
    
    waix = 5;

end