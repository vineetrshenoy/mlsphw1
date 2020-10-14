%% Load Notes and Music
% Use the 'load_data' function here
[smagNote, smagMusic, sphaseMusic] = load_data();
%% Calculate the weight matrix (eqn. 7)
% W = pinv(N)*M -- but this might have negative values. 
% Solving for W in M=NW with the constraint W>0 is non-trivial. Hence we
% solve for W using the iterative process below.
W = pinv(smagNote)*smagMusic;

%% Step 1: Error calculation

%% Step 2: Gradient Descent
%Call the gradDescent function - ensure max_iter = 500
w0 = ones(size(W));
eta = 0.01;
max_iterations = 500;
[w_final, errors] = gradDescent(w0,eta,max_iterations,smagMusic, smagNote);

%% Step 3: Reconstruction (optional)

