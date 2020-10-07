%% Driver File for Problem 1: Part 2: Face Detection
% You will implement an Adaboost Classifier to classify between face images
% and non-face images.
% Author Name : Vineet Shenoy

clear,clc

train_mat = load_training_data('../data/lfw_1000');

train_mat_normalized = zscore(train_mat, 0, 2);

[U, S, V] = svd(train_mat_normalized, 0);

train_f_loc = '../data/boosting_data/train/face';
train_nf_loc =  '../data/boosting_data/train/non-face';

[train_data, train_labels] = get_weights(train_f_loc, train_nf_loc, U, 10);

Mdl = fitcensemble(train_data', train_labels, 'Method', 'AdaBoostM1');

test_f_loc = '../data/boosting_data/test/face';
test_nf_loc = '../data/boosting_data/test/non-face';

[test_data, test_labels] = get_weights(train_f_loc, train_nf_loc, U, 10);

out_labels = predict(Mdl, test_data');


difference = test_labels - out_labels';

[r,c] = size(test_data);
accuracy = (c - nnz(difference)) / c