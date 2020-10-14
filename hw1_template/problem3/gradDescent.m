function [final_weight, errors] = gradDescent(w0,eta,n, M, notes)
% Inputs:
% w0 = initial weight matrix (should be all ones in this case)
% eta = learning rate
% n = number of iterations
% Output:
% final_weight = weight matrix at the end of 'n' iterations
% errors = error values at each iteration 
% Ensure the max(W,0) constraint used in each iteration
iter_idx = 0;
w_old = w0;
[F, T] = size(M);
errors = [];
while iter_idx < n
    % calculate and track error 
    f_norm = norm(M - notes*w_old,'fro');
    error = (1/(F*T))*f_norm*f_norm;
    errors = [errors, error];
    % update W 
    % gradient = (-2/(F*T))*(notes'*(M-notes*w_old));
    gradient = (-2)*(notes'*(M-notes*w_old));
    update = w_old - eta*gradient;
    w_new = max(update, 0);
    w_old = w_new;
    iter_idx = iter_idx + 1;
end

final_weight = w_new;
% return final_weight
end