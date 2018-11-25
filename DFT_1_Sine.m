function [] = DFT_1_Sine( f1, N, Nzp )
% Part 1 - Seth Arnold and Will Cass

% DESCRIPTION:
% This function uses the three inputs to compute and plot the DFT of a
% sinusoid with amplitude 1, frequency "f1", and phase 0.
% The DFT is done with "N" samples and "Nzp" zero padding.
% Next, a "Hamming Window" of length "N" is created and plotted.
% Finally, the DFT of the new windowed sinusoid is calculated and plotted
% with "N" samples and "Nzp" zero padding.

% USEAGE: DFT_1_Sine(f1,N,Nzp)

% INPUTS: This function accepts 3 inputs:
% "f1" is input sinusoid frequency in Hz
% "N" is the number of samples taken
% "Nzp" is the amount of zero padding

% OUTPUTS: No variables, only figures

% PLOTS:
% Figure 1 - Plots the hammed and unhammed DFTs of the input sinusoid on
% two subplots
% Figure 2 - Plots the hamming window vs time

Fs = 4410; 
% Sampling rate in Hz

i = 1:N;
x = sin(f1*2*pi*(i/Fs)); 
% Creates a row vector "x" with "N" samples of the input sinusoid

omega = ((-(N+Nzp)/2):((N+Nzp)/2-1))*(pi*2/(N+Nzp));
% Creates "omega" a row vector from -pi radians/sample to pi radians/sample 
% for plotting the DFT against
omega = omega*4410/(2*pi);
% Change omega to Hz

X = fftshift(fft(x,N+Nzp));
mag = mag2db(abs(X));
% Creates "X" the DFT of the input sinusoid
% Takes the magnitude of the result, converts to dB

w = hamming(N);
w= w';
xw=x.*w;
% Creates the "Hamming window" and corrects it to a row vector
% Multiplies x by w creating xw, the adjusted sinusoid

XW=fftshift(fft(xw,N+Nzp));
mag2 = mag2db(abs(XW));
% Creates "XW" the DFT of the hammed input sinusoid
% Takes the magnitude of the result, converts to dB

t=(0:N-1)/Fs; 
% Creates "t" a row vector containing time values to plot the hamming
% window against

figure
subplot(2,1,1)
plot(omega,mag)
xlim([-2204 2204])
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('DFT of a sinusoid with "f1" frequency, "N" samples, "Nzp" zero padding')
% Plots the DFT of the input sinusoid

subplot(2,1,2)
plot(omega,mag2)
xlim([-2204 2204])
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('DFT of a "Hammed" sinusoid with "f1" frequency, "N" samples, "Nzp" zero padding')
% Plots the DFT of the hammed input sinusoid

figure
plot(t,w)
xlabel('Time (sec)')
ylabel('Magnitude Adjustment')
title('Hamming Window')
% Plots the hamming window

end

