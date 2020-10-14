%% Driver File for Problem 1: Part 1: Face Detection
% Implement a simple face detector that can detect faces in group 
% photos of people.
% Author Name : (Your name here)


%% Your Driver Script Starts Here

% Follow the steps in methodology here

% 1. Load training data in a matrix 
files = dir('../data/lfw_1000/*.pgm');
X = zeros(64*64, size(files,1)); % X will be the data matrix of dimension (64*64, N) where N is the number of training images 
mean = zeros(64*64, 1); % will store the mean of training data 

for i=1:length(files)
    im = imread([files(i).folder '/' files(i).name]);
    unrolled_im = double(reshape(im, [64*64,1]));
    X(:,i) = unrolled_im;
    mean = mean + unrolled_im;
end
mean = mean/size(files,1);

for i=1:length(files)
    X(:,i) = X(:,i) - mean;
end

% 2. Find the first eigen face 
[U, S, V] = svd(X);

figure(1);
imshow(reshape(U(:,1),64,64),[]);
title('First eigenface');

eigface1 = U(:,1);

% 3. Load test image and obtain scaled versions; convert to grayscale if
% needed 
scale_factors = [0.5, 0.75, 1.0, 1.5, 2.0];
test_img = imread('../data/group_photos/Big_3.jpg');
scaled_imgs = {};
i = 1;
for scale=scale_factors
    scaled_imgs{i} = double(imresize(test_img, scale));
    i = i+1;
end

scores = {};
cts = zeros(5,1);
% 4. Sliding window of 64x64 and compute & store match_score for each 
for idx=1:length(scale_factors)
    fprintf('sliding window: %i\n', idx);
    curr_img = scaled_imgs{idx};
    [h,w] = size(curr_img);
    curr_scores = zeros(h,w);
    ct = 0;
    for i=1:h
        for j=1:w 
            if i+64 <= h & j+64<=w
                ct = ct + 1;
                test_window = curr_img(i:i+64-1, j:j+64-1);
                test_window_unrolled = reshape(test_window, [64*64,1]) - mean;
                test_window_norm = test_window_unrolled/norm(test_window_unrolled);
                match_score = dot(test_window_norm, eigface1);
                curr_scores(i,j) = match_score;
            end
        end
    end
    cts(idx) = ct/(h*w);
    scores{idx} = curr_scores;
end

% 5. Find the peak and scale it back to original image 


% 6. Combine these multiple peaks 

%%  TODO: mean center test window. which mean? 

% A = scores{3};
% ii = 1;
% figure();
% imshow(test_img);
% hold on;
% while ii<1000
%     maximum = max(max(A));
%     [x,y]=find(A==maximum);
%     rectangle('Position',[x,y,64,64], 'EdgeColor', 'red');
%     A(x,y) = 0;
%     ii = ii+1;
% end



