function [] = DFT_2_Sine( f1,f2,a,N,Nzp )
% Part 2 - Seth Arnold and Will Cass

% DESCRIPTION: 
% This function uses the 5 inputs to compute and plot the DFT of:
% sinusoid 1 with amplitude 1, frequency "f1", phase 0.
% sinusoid 2 with amplitude "a", frequency "f2", phase 0.
% Both DFT calculations are done with "N" samples and "Nzp" zero padding.
% Next, a "Hamming Window" of length "N" is created and plotted.
% Finally, the DFT of the new hammed sinusoids are calculated and plotted
% with "N" samples and "Nzp" zero padding.

% USEAGE: DFT_2_Sine(f1,f2,a,N,Nzp)

% INPUTS: This function accepts 5 inputs:
% "f1" is the frequency of sinusoid 1 in Hz
% "f2" is the frequency of sinusoid 2 in Hz
% "a" is amplitude of sinusoid 2 in volts
% "N" is the number of samples taken
% "Nzp" is zero padding in samples

% OUTPUTS: No variables, only figures

% PLOTS:
% Figure 1 - Plots the hammed and unhammed DFTs of the input sinusoid 1 
% and 2 on two subplots
% Figure 2 - Plots the hamming window

Fs = 4410; 
% Sampling rate in Hz

i = 1:N;
x = 1*sin(f1*2*pi*(i/Fs));
y = a*sin(f2*2*pi*(i/Fs));
% Creates a row vector "x" with "N" samples of the input sinusoid 1
% Creates a row vector "y" with "N" samples of the input sinusoid 2

omega = ((-(N+Nzp)/2):((N+Nzp)/2-1))*(pi*2/(N+Nzp));
% Creates "omega" a row vector from -pi radians/sample to pi radians/sample 
% for plotting the DFT against
omega = omega*4410/(2*pi);
% Change omega to Hz

X = fftshift(fft(x,N+Nzp));
magx = mag2db(abs(X));
% Creates "X" the DFT of the input sinusoid 1
% Takes the magnitude of the result, converts to dB

Y = fftshift(fft(y,N+Nzp));
magy = mag2db(abs(Y));
% Creates "Y" the DFT of the input sinusoid 2
% Takes the magnitude of the result, converts to dB

w = hamming(N);
w= w';
xw=x.*w;
yw=y.*w;
% Creates the "Hamming window" for both sinusoid 1 and 2 and corrects it 
% to a row vector
% Multiplies x by w creating xw, the adjusted sinusoid 1
% Multiplies y by w creating yw, the adjusted sinusoid 2

XW=fftshift(fft(xw,N+Nzp));
magXW = mag2db(abs(XW));
% Creates "XW" the DFT of the hammed input sinusoid 1
% Takes the magnitude of the result, converts to dB

YW=fftshift(fft(yw,N+Nzp));
magYW = mag2db(abs(YW));
% Creates "YW" the DFT of the hammed input sinusoid 2
% Takes the magnitude of the result, converts to dB

t=(0:N-1)/Fs;
% Creates "t" a row vector containing time values to plot the hamming
% window against

%%%%%%%%%%
% Sinusoid 1

figure
subplot(2,1,1)
plot(omega,magx,'k',omega,magy,'r')
xlim([-2204 2204])
legend('Sinusoid 1','Sinusoid 2')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('DFT of sinusoids "f1"&"f2" frequency, "N" samples, "Nzp" zero padding,"a" amplitude for sinusoid 2')
% Plots the DFT of the input sinusoid 1&2

subplot(2,1,2)
plot(omega,magXW,'k',omega,magYW,'r')
xlim([-2204 2204])
legend('Sinusoid 1','Sinusoid 2')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
title('DFT of "Hammed" sinusoids "f1"&"f2" frequency, "N" samples, "Nzp" zero padding,"a" amplitude for sinusoid 2')
% Plots the DFT of the hammed input sinusoids 1&2

%%%%%%%%%%

figure
plot(t,w)
xlabel('Time (sec)')
ylabel('Magnitude Adjustment')
title('Hamming Window')
% Plots the hamming window

end

