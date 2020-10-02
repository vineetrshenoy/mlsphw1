function [train_mat] = load_training_data(direc)
    %Loads the training data into a matrix

    
    D = dir(direc);
    N_samples = length(D) - 2; % two hidden folders are not counted
    train_mat = zeros(250*250, N_samples);
    
    count = 1;
   
    for i=3:length(D)
        
        
        A = half(double(imread(fullfile(direc, D(i).name))));
        train_mat(:, count) = A(:);
        count = count + 1;

    end

end
