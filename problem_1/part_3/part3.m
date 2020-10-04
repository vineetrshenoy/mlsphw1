clear,clc

N = 1934
%Find average male and female face
train_data = load('train_data.mat').train_data;

mens = train_data(:, 1:N);
womens = train_data(:, N+1:end);

mens_mean = mean(mens, 2);
womens_mean = mean(womens, 2);


figure(1)
imshow(reshape(mens_mean, [250, 250]), [])

figure(2)
imshow(reshape(womens_mean, [250, 250]), [])




U = load('U.mat').U;
S = load('S.mat').S;




eigenvalues = diag(S.^2);

num = length(eigenvalues);

plot(1:num, eigenvalues);
title('Eigenvalues')


[test_data, mlen, wlen] = load_data('../data/lfw_genders/male/test', '../data/lfw_genders/female/test');

