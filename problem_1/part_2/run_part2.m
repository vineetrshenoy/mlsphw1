%% Driver File for Problem 1: Part 2: Face Detection
% You will implement an Adaboost Classifier to classify between face images
% and non-face images.
% Author Name : Vineet Shenoy

clear,clc

train_mat = load_training_data('../data/lfw_1000');

train_mat_normalized = zscore(train_mat);

[U, S, V] = svd(train_mat_normalized, 0);

boost_train_face = load_boosting_data('../data/boosting_data/train/face');
weight_face = pinv(U(:, 1:10)) * boost_train_face;


%A =  U(:, 1:10) * weight(:, 1);
boost_train_noface = load_boosting_data('../data/boosting_data/train/non-face');
weight_noface = pinv(U(:, 1:10)) * boost_train_noface;