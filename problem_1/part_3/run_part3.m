%% Driver File for Problem 1: Part 3: Gender Detection
% You will build a gender detection system using the PCA dimensions 
% from images.
% Author Name : Vineet Shenoy

clear,clc
[train_data, mlen, wlen] = load_data('../data/lfw_genders/male/train', '../data/lfw_genders/female/train');
train_mean = mean(train_data, 2);
mean_train = double(train_data) - train_mean;

x = 5
%train_data_mean = mean(train_data, 2);
%[X, Y] = meshgrid(ones(w, 1), train_data_mean);
%result = train_data_mean - Y;
