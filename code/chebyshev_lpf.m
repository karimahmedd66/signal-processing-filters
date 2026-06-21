% Chebyshev Type I Lowpass Filter Design and Application

clc;
clear;
close all;

%% Filter Specifications
f_s = 8000;        % Sampling Frequency (Hz)
f_p = 1000;        % Passband Edge Frequency (Hz)
f_s_stop = 1500;   % Stopband Edge Frequency (Hz)
Rp = 1;            % Passband Ripple (dB)
Rs = 40;           % Stopband Attenuation (dB)

%% Step 1: Normalize the frequencies
wp = f_p / (f_s/2);        % Normalized passband frequency
ws = f_s_stop / (f_s/2);   % Normalized stopband frequency

%% Step 2: Calculate minimum filter order and cutoff frequency
[N, Wn] = cheb1ord(wp, ws, Rp, Rs);

%% Step 3: Design the Chebyshev Type I filter
[b, a] = cheby1(N, Rp, Wn);

%% Step 4: Generate a noisy signal
t = 0:1/f_s:1;                 % Time vector for 1 second
signal_clean = sin(2*pi*300*t); % Pure 300 Hz sine wave
noise = 0.5*randn(size(t));     % Random noise
signal_noisy = signal_clean + noise;  % Noisy signal

%% Step 5: Filter the noisy signal
signal_filtered = filter(b, a, signal_noisy);

%% Step 6: Plot signals (Original + Filtered)
figure;
subplot(2,1,1);
plot(t, signal_noisy);
title('Original Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t, signal_filtered);
title('Filtered Signal (After Chebyshev Type I Lowpass)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

%% Step 7: Plot Magnitude Response separately
figure;
[h, w] = freqz(b, a, 1024, f_s);
plot(w, abs(h), 'LineWidth', 1.5);
title('Magnitude Response of Chebyshev Type I Filter');
xlabel('Frequency (Hz)');
ylabel('|H(f)|');       
grid on;
