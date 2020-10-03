function [train_mat, men_length, women_length] = load_data(direc1, direc2)
    %Loads the training data into a matrix

    
    D = dir(direc1);
    B = dir(direc2);
    
    men_length = length(D) - 2;
    women_length = length(B) - 2;
    
    N_samples = men_length + women_length; % two hidden folders are not counted
    train_mat = zeros(250*250, N_samples);
    


    count = 1;
   
    for i=3:length(D)
        
        
        A = uint8(imread(fullfile(direc1, D(i).name)));
        train_mat(:, count) = A(:);
        count = count + 1;

    end


    for i=3:length(B)
        
        
        A = uint8(imread(fullfile(direc2, B(i).name)));
        train_mat(:, count) = A(:);
        count = count + 1;

    end

end
