function [smagNote, smagMusic, sphaseMusic] = load_data()
%% Argument Descriptions
% Required Input Arguments:
% None


% Required Output Arguments:
% smagNote: 1025 x 11 matrix containing the mean spectrum magnitudes of the notes. A correct sequence of the notes is REQUIRED. (From left to right: e f g a b c d e2 f2 g2 a2)
% smagMusic: 1025 x K matrix containing the spectrum magnitueds of the music after STFT.
% sphaseMusic: 1025 x K matrix containing the spectrum phases of the music after STFT.

%% Load Spectrum Magnitudes of Notes
% Fill your code here to return 'smagNote'

%% Load Spectrum Magnitues and Phases of The Provided Music
% Fill your code here to return 'smagMusic' and 'sphaseMusic'



smagNote = read_notes();

[s, fs] = audioread('data/polyushka.wav');
s = resample(s, 16000, fs);
spectrum = stft_hw(s(:,1)', 2048, 256, 0, hann(2048));
smagMusic = abs(spectrum);
sphaseMusic = spectrum ./ (abs(spectrum) + eps);

end