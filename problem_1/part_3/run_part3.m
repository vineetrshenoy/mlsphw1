%% Driver File for Problem 1: Part 3: Gender Detection
% You will build a gender detection system using the PCA dimensions 
% from images.
% Author Name : Vineet Shenoy

clear,clc
mens_train = load_data('../data/lfw_genders/male/train');
womens_train = load_data('../data/lfw_genders/female/train');

[h_mens, w_mens] = size(mens_train);
[h_womens, w_womens] = size(womens_train);

train_data = [mens_train, womens_train];
[h, w] = size(train_data);

%train_data_mean = mean(train_data, 2);
%[X, Y] = meshgrid(ones(w, 1), train_data_mean);
%result = train_data_mean - Y;
