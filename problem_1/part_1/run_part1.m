%% Driver File for Problem 1: Part 1: Face Detection
% Implement a simple face detector that can detect faces in group 
% photos of people.
% Author Name : Vineet Shenoy
clear, clc

train_mat = load_training_data('../data/lfw_1000');
[row, col] = size(train_mat);
[U, S, V] = svd(train_mat, 0); %Get eigenvectors + eigenvalues
eigenvalues = diag(S.^2);
%{
fig1 = figure(1); %plotting the eigenvalues
plot(1:col, eigenvalues)
title('Eigenvalues')
saveas(gcf, 'eigenvalues.png')

fig2 = figure(2); %Showing the first eigenface
first_eigen_face = reshape(U(:, 1), [64, 64]);
title('First Eigen Face')
imshow(first_eigen_face, [])
saveas(fig2, 'first_eigen_face.png')
%}

%%%%%%%%%%%%%%%%%%%%

%Loads and converts all images to grayscales
beatles = double(imread('../data/group_photos/Beatles.jpg'));
beatles = squeeze(mean(beatles,3));
big3 = double(imread('../data/group_photos/Big_3.jpg'));
big3 = squeeze(mean(big3,3));
g8 = double(imread('../data/group_photos/G8.jpg'));
g8 = squeeze(mean(g8,3));
solvay = double(imread('../data/group_photos/Solvay.jpg'));
solvay = squeeze(mean(solvay,3));

loc = scale_scan(U, beatles, 4, 30);
draw(beatles, loc);

loc = scale_scan(U, big3, 3);

loc = scale_scan(U, g8, 8);

loc = scale_scan(U, solvay, 29);

