% Part 3 - Seth Arnold and Will Cass

% DESCRIPTION:
% This script reads in recordings of 3 guitar notes, A, E, and D, and saves
% them in memory.
% The notes are plotted vs time.
% The notes are plotted vs time for t=4 to t=5.
% The DFT of each note is calculated for the t=4 to t=5 section.
% Hamming for each note is calculated.
% The DFT of each note is taken with hamming.
% Both DFTs are plotted. With and without hamming.

% USEAGE: DFT_Real_Guitar

% INPUTS: This is a script, and accepts no user.
% The script does load 
% 'E_String.wav'
% 'A_String.wav'
% 'D_String.wav'
% into memory

% OUTPUTS: No variables, only plots.

% PLOTS: 
% Figure 1 - Plots each of the the unchanged input signals vs time
% Figure 2 - Plots each of the the input signals vs time for t=4 to t=5
% Figure 3 - Plots the hamming window
% Figure 4 - Plots the hammed DFT and unhammed DFT of the A note signal
% Figure 5 - Plots the hammed DFT and unhammed DFT of the E note signal
% Figure 6 - Plots the hammed DFT and unhammed DFT of the D note signal


Fs = 4410;
% Sampling rate in Hz

Nzp = 1000; 
% Zero padding

x_E = audioread('E_String.wav');
x_A = audioread('A_String.wav');
x_D = audioread('D_String.wav');
% Reading in data for each note

t_E=1:length(x_E);
t_E=t_E';
t_E=t_E./4410;

t_A=1:length(x_A);
t_A=t_A';
t_A=t_A./4410;

t_D=1:length(x_D);
t_D=t_D';
t_D=t_D./4410;
% Creates a time vector in sec for each note
% This allows us to plot the amplitude of the note vs time

figure
subplot(3,1,1)
plot(t_E,x_E)
xlabel('Time (sec)')
ylabel('Amplitude')
title('E String')

subplot(3,1,2)
plot(t_D,x_D)
xlabel('Time (sec)')
ylabel('Amplitude')
title('D String')

subplot(3,1,3)
plot(t_A,x_A)
xlabel('Time (sec)')
ylabel('Amplitude')
title('A String')
% Creates 1 figure with 3 subplots
% Plots the amplitude of each note vs time

%%%%%%%%%%

x_E=x_E([4*Fs:5*Fs+1]);
x_D=x_D([4*Fs:5*Fs+1]);
x_A=x_A([4*Fs:5*Fs+1]);
t=(4:1/Fs:5+1/Fs);
% Extracting the information that lies between t=4 and t=5

figure
subplot(3,1,1)
plot(t,x_E)
xlabel('Time (sec)')
ylabel('Amplitude')
title('E String')
xlim([4 5])

subplot(3,1,2)
plot(t,x_D)
xlabel('Time (sec)')
ylabel('Amplitude')
title('D String')
xlim([4 5])

subplot(3,1,3)
plot(t,x_A)
xlabel('Time (sec)')
ylabel('Amplitude')
title('A String')
xlim([4 5])
% Creates 1 figure with 3 subplots
% Plots the amplitude of each note vs time for t=4 to t=5

%%%%%%%%%

dft_A=fftshift(fft(x_A,length(t)+Nzp));
dft_D=fftshift(fft(x_D,length(t)+Nzp));
dft_E=fftshift(fft(x_E,length(t)+Nzp));
% Calculates the DFT of each note

magA=mag2db(abs(dft_A));
magE=mag2db(abs(dft_E));
magD=mag2db(abs(dft_D));
% Takes the magnitude of the result, converts to dB

%%%%%%%%%%

w = hamming(length(t));
aw=x_A.*w;
ew=x_E.*w;
dw=x_D.*w;
% Creates the hamming window for each note
% Multiplies A by w creating aw, the adjusted sinusoid
% Multiplies E by w creating ew, the adjusted sinusoid
% Multiplies D by w creating dw, the adjusted sinusoid

t=(0:4411)/Fs;
% Creates "t" a row vector containing time values to plot the hamming
% window against

figure
plot(t,w')
xlabel('Time (sec)')
ylabel('Magnitude Adjustment')
title('Hamming Window')
xlim([0 1])
% Plots the hamming window

AW=fftshift(fft(aw,length(t)+Nzp));
EW=fftshift(fft(ew,length(t)+Nzp));
DW=fftshift(fft(dw,length(t)+Nzp));
% Calculates the DFT of each hammed note

magAW=mag2db(abs(AW));
magDW=mag2db(abs(DW));
magEW=mag2db(abs(EW));
% Takes the magnitude of the result, converts to dB

%%%%%%%%%%

omega = ((-(length(t)+Nzp)/2):((length(t)+Nzp)/2-1))*(pi*2/(length(t)+Nzp));
% Creates "omega" a row vector from -pi radians/sample to pi radians/sample 
% for plotting the DFT against
omega = omega*4410/(2*pi);
% Change omega to Hz

figure
subplot(2,1,1)
plot(omega,magA)
title('A String - No Hamming');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
xlim([0 1000])
subplot(2,1,2)
plot(omega,magAW)
title('A String with Hamming');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
xlim([0 1000])
% Creates 1 figure with 2 subplots
% Plots the DFT of A note with and without hamming

figure
subplot(2,1,1)
plot(omega,magE)
title('E String - No Hamming')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
xlim([0 1000])
subplot(2,1,2)
plot(omega,magEW)
title('E String with Hamming');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
xlim([0 1000])
% Creates 1 figure with 2 subplots
% Plots the DFT of E note with and without hamming

figure
subplot(2,1,1)
plot(omega,magD)
title('D String - No Hamming');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
xlim([0 1000])
subplot(2,1,2)
plot(omega,magDW)
title('D String with Hamming');
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
xlim([0 1000])
% Creates 1 figure with 2 subplots
% Plots the DFT of D note with and without hamming
