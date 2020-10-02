function [notes] = read_notes()
    
    notesfolder = 'data/notes_15/';
    listname = dir([notesfolder '*.wav']);
    notes = [];

    for k = 1:length(listname);

        [s, fs] = audioread([notesfolder listname(k).name]);
        s = resample(s, 16000, fs);
        spectrum = stft_hw(s(:,1)', 2048, 256, 0, hann(2048));
        %find the central frame
        middle = ceil(size(spectrum, 2)/2);
        
        note = abs(spectrum(:, middle));
        % Clean up everything more than 40db below the peak
        note(find(note < max(note(:))/100)) = 0;
        note = note/norm(note); %normalize the note to unit length

        notes = [notes, note];



end