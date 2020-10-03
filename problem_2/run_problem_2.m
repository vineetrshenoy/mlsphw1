clear, clc
%% Load Notes and Music
% Use the 'load_data' function here
[smagNote, smagMusic, sphaseMusic] = load_data();
[h_note, wnote] = size(smagNote);
[h_music, w_music] = size(smagMusic);

x = 5;

%% Solution for Problem 2.1 here

% Place all the 15 scores W_i (for the 15 notes) into a single matrix W. 
% Place  the score for the i-th note in the i-th row of W.
% W will be a 15xT matrix, where T is the number of frames in the music.
% Store W in a text file called "problem2a.dat"

transcript = zeros(wnote, w_music);

for i=1:wnote

    [B,W,obj,k] = get_weights(smagMusic, smagNote(:, i), 500);
    transcript(i, :) = W(:);

end

reconstruct_notes(smagNote, transcript, sphaseMusic)




%% Solution to Problem 2.2 here:  Synthesize Music
% Use the 'synthesize_music' function here.
% Use 'wavwrite' function to write the synthesized music as 'problem2b_synthesis.wav' to the 'results' folder.

[B,W,obj,k] = get_weights(smagMusic, smagNote, 500);

M = smagNote * W;

reconstructedsignal = stft_hw(M.*sphaseMusic,2048,256,0,hann(2048));
audiowrite('results/problem2b_synthesis.wav', reconstructedsignal, 16000);
save('results/problem2b.dat','W','-ascii','-double','-tabs');