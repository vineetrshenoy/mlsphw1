%% Driver File for Problem 1: Part 2: Face Detection
% You will implement an Adaboost Classifier to classify between face images
% and non-face images.
% Author Name : Ketul Shah 


%% Your Driver Script Starts Here
% You can use as many auxilliary scripts as you want
% As long as we can run this script to get all the plots and classification
% accuracies we require from Part 2

%% 1. Compute eigenvectors using SVD 
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

[U, S, V] = svd(X);

%% 2. Obtain the features for face and non-face images (of size K)
K = 10;
% load training data - faces and non-faces 
train_faces_files = dir('../data/boosting_data/train/face/*.pgm');
training_data_faces = zeros(19*19, size(train_faces_files,1));
for i=1:length(train_faces_files)
    im = imread([train_faces_files(i).folder '/' train_faces_files(i).name]);
    unrolled_im = double(reshape(im, [19*19,1]));
    training_data_faces(:,i) = unrolled_im;
end

train_nonfaces_files = dir('../data/boosting_data/train/non-face/*.pgm');
training_data_nonfaces = zeros(19*19, size(train_nonfaces_files,1));
for i=1:length(train_nonfaces_files)
    im = imread([train_nonfaces_files(i).folder '/' train_nonfaces_files(i).name]);
    unrolled_im = double(reshape(im, [19*19,1]));
    training_data_nonfaces(:,i) = unrolled_im;
end

% obtain features for training data - faces and non-faces 
topk_eig_faces = U(:,1:K);
% resize eigenfaces to 19x19
topk_eig_faces_resized = zeros(19*19, K);
for i=1:K
    eigface = topk_eig_faces(:,i);
    resized_eigface = double(reshape(imresize(reshape(eigface, [64,64]), [19,19]), [19*19,1]));
    topk_eig_faces_resized(:,i) = resized_eigface;
end

face_train_feats = training_data_faces'*topk_eig_faces_resized;
nonface_train_feats = training_data_nonfaces'*topk_eig_faces_resized;

%% 3. Learn the adaboost classifier 

num_iters = 10; % number of iterations we run our adaboost algo; we get this weak classifiers  

train_labels = [ones(2429,1); -1*ones(4548,1)];
train_feats = [face_train_feats; nonface_train_feats];

weights = (1/size(train_feats,1))*ones(size(train_feats,1),1); % initialize weights as uniform dist 

alphas = zeros(num_iters, 1);
%TODO: variable to hold classifiers  
classifiers = {};
dims = {};

for iter=1:num_iters
    min_error = inf;
    % get the decision stump that has least error among all dimensions
    for dim=1:K
        ctree = fitctree(train_feats(:,dim), train_labels, 'minparent',size(train_labels,1),'prune','off','mergeleaves','off', 'Weights',weights);
        error = loss(ctree, train_feats(:,dim), train_labels, 'Weights', weights);
        if error < min_error
            min_error = error;
            best_classifier = ctree;
            best_dim = dim;
        end
    end
    dims{iter} = best_dim;
    classifiers{iter} = best_classifier;
    % calculate alpha
    alpha = 0.5*log((1-min_error)/min_error);
    alphas(iter) = alpha;
    % update weights 
    pred_labels = predict(best_classifier, train_feats(:,dim));
    for i=1:size(train_feats,1)
        weights(i) = weights(i)*exp(-alpha*train_labels(i)*pred_labels(i));
    end 
    % normalize weights 
    weights = weights/sum(weights); 
end

%% 4. Get accuracy on test data 

% Load test data 
test_faces_files = dir('../data/boosting_data/test/face/*.pgm');
test_data_faces = zeros(19*19, size(test_faces_files,1));
for i=1:length(test_faces_files)
    im = imread([test_faces_files(i).folder '/' test_faces_files(i).name]);
    unrolled_im = double(reshape(im, [19*19,1]));
    test_data_faces(:,i) = unrolled_im;
end

test_nonfaces_files = dir('../data/boosting_data/test/non-face/*.pgm');
test_data_nonfaces = zeros(19*19, size(test_nonfaces_files,1));
for i=1:length(test_nonfaces_files)
    im = imread([test_nonfaces_files(i).folder '/' test_nonfaces_files(i).name]);
    unrolled_im = double(reshape(im, [19*19,1]));
    test_data_nonfaces(:,i) = unrolled_im;
end

% obtain features for test data 
face_test_feats = test_data_faces'*topk_eig_faces_resized;
nonface_test_feats = test_data_nonfaces'*topk_eig_faces_resized;

test_labels = [ones(size(face_test_feats,1),1); -1*ones(size(nonface_test_feats,1),1)];
test_feats = [face_test_feats; nonface_test_feats];

% get predictions for the test data using all classifiers 
logits = zeros(size(test_labels,1),1);
for iter=1:num_iters
    logits = logits + alphas(iter)*predict(classifiers{iter}, test_feats(:,dims{iter}));
end

test_labels_pred = sign(logits);

accuracy = sum(test_labels == test_labels_pred) / size(test_labels,1);










