clear,clc

N = 1934;
%Find average male and female face
train_data = load('train_data.mat').train_data;

mens = train_data(:, 1:N);
womens = train_data(:, N+1:end);

mens_mean = mean(mens, 2);
womens_mean = mean(womens, 2);


figure(1)
imshow(reshape(mens_mean, [250, 250]), []);
title('Average Male face');

figure(2)
imshow(reshape(womens_mean, [250, 250]), []);
title('Average Female Face');

clear train_data;

U = load('U.mat').U;
S = load('S.mat').S;


eigenvalues = diag(S.^2);

num = length(eigenvalues);

figure(3)
plot(1:num, eigenvalues);
title('Eigenvalues')

clear S;

[test_data, mlen, wlen] = load_data('../data/lfw_genders/male/test', '../data/lfw_genders/female/test');


tic
[acc50_mean, cl] = simple_gender(U, 50, mens_mean, womens_mean, test_data);
toc
acc50_mean


tic
[acc100_mean, cl] = simple_gender(U, 100, mens_mean, womens_mean, test_data);
toc
acc100_mean

tic
[acc200_mean, cl] = simple_gender(U, 200, mens_mean, womens_mean, test_data);
toc
acc200_mean

tic
[acc300_mean, cl] = simple_gender(U, 300, mens_mean, womens_mean, test_data);
toc
acc300_mean



train_data = load('train_data.mat').train_data;
tic
[acc50_full, cl] = complex_gender(U, 50, train_data, test_data);
toc
acc50_full

tic
[acc100_full, cl] = complex_gender(U, 100, train_data, test_data);
toc
acc100_full

tic
[acc200_full, cl] = complex_gender(U, 200, train_data, test_data);
toc
acc200_full
%}