%% Author: Xuyi Ruan 
%% reference: 
% http://www.mathworks.com/matlabcentral/fileexchange/38837-sound-analysis-with-matlab-implementation/content/Sound_Analysis.m
% https://books.google.com/books?id=KXwAAQAAQBAJ&pg=PA11&lpg=PA11&dq=pcm+extension+matlab&source=bl&ots=o-AYfPikpI&sig=uXRjwJfsXW76KcHoJZPVeTWZaR8&hl=en&sa=X&ved=0CE4Q6AEwB2oVChMI58nT4O2EyQIVCPM-Ch2jcwlC#v=onepage&q=pcm%20extension%20matlab&f=false
% plot in dB: https://dadorran.wordpress.com/2014/02/20/plotting-frequency-spectrum-using-matlab/

clear

% read in pcm file

fid = fopen('high_freq.pcm', 'r');
sound = fread(fid, inf, 'int16', 0, 'ieee-be');
fclose (fid);

sound = sound(:,1);             % get the first channel
sound_max = max(abs(sound));     % find the maximum value
sound = sound/sound_max;             % scalling the signal

% time & discretisation parameters
N = length(sound);
fs = 44100;
t = (0:N-1)/fs; 

% plotting of the waveform
figure(1)
plot(t, sound, 'r')
xlim([0 max(t)])
ylim([-1.1*max(abs(sound)) 1.1*max(abs(sound))])
grid on
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
xlabel('Time, s')
ylabel('Normalized amplitude')
title('The signal in the time domain')


% play audio
soundsc(sound, fs);


% compute the DFT of signal 'x'
rapX = abs(fft(sound));
%fhat = (-N/2:N/2-1)/N;
fhat = [0: N-1]/N;
fHz = fhat*fs;
fhat_2 = ceil(N/2);

% target_freq
freq_target = 18000;
fhat_target = ceil((freq_target/fs)*N);
low_bound = fhat_target - ceil(800/(fs/N));
high_bound = fhat_target + ceil(800/(fs/N));


figure
plot(fHz(low_bound:high_bound), 10*log10(rapX(low_bound:high_bound)))
%plot(fHz(1:fhat_2), 10*log10(rapX(1:fhat_2)))
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
grid on
title('DFT Frequency Analysis');


