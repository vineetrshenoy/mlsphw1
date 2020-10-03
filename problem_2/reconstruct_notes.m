function [] = reconstruct_notes(notes, weights, phase)

    [hnote, wnote] = size(notes);
    [hweights, wweights] = size(weights);

    %{
    recon = zeros(hnote, wweights);

    for i = 1:w

        recon = recon + notes(:, i) * weights(i, :);

    end
    %}

    recon = notes*weights;
    reconstructedsignal = stft_hw(recon.*phase,2048,256,0,hann(2048));
    save('results/problem2a.dat','weights','-ascii','-double','-tabs');
    audiowrite('results/problem2a_synthesis.wav', reconstructedsignal, 16000);



end