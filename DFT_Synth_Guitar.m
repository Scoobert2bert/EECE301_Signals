function [x,XW] = DFT_Synth_Guitar( fo )
% Part 4 - Seth Arnold and Will Cass

% DESCRIPTION:
% This function generates a synthetic guitar signal at the input frequency
% "fo"
% The 1 second signal is generated using decresing amplitudes to simulate harmonics
% and 10 random phases to simulate real world variability
% The hamming window is found for the generated signal
% The DFT of the hammed signal is found
% The hammed DFT is plotted

% USEAGE: [x,X] = DFT_Real_Guitar(fo)

% INPUTS: This function acceps 1 input
% "fo" is the frequency of the signal to be generated

% OUTPUTS: This function has 2 outputs
% "x" is the vector containing the generated signal
% "X" is the vector containing the hammed DFT of the generated signal

% PLOTS: 
% Figure 1 - Plots the hammed DFT of the generated signal

Nzp = 1000; 
% "Nzp" is the zero padding amount

N = 4410;
% "N" is the number of samples

T=1/N; 
% amount of time change per sample

t=0:T:1; 
% creation of time vector

A=[.07 .025 .013 .007 .003 .002 .0004 .0003 .0002 .0001];
% amplitude values for sinusoids

phase=2*pi*rand(1,10);
% phase values generated using rand for sinusoids

x=zeros([1 N+1]);
% zeroes created as placeholders for future x values

for i=1:10
      y=A(i)*cos(2*pi*i*fo*t+phase(i));
      % Creates sinusoid for the current i value
      x=x+y;
      % adds sinusoid to previous values to create total
end

fo = hamming(length(x));
fo= fo';
xw=x.*fo;
% Creates the "Hamming window" for the summed sinusoids and corrects it 
% to a row vector
% Multiplies x by fo creating xw, the adjusted sinusoid

XW=fftshift(fft(xw,N+Nzp));
XW=mag2db(abs(XW));
% computes the hammed DFT & converts to dB

omega = ((-(N+Nzp)/2):((N+Nzp-1)/2))*(pi*2/(N+Nzp));
% Creates "omega" a row vector from -pi radians/sample to pi radians/sample 
% for plotting the DFT against
omega = omega*4410/(2*pi);
% Change omega to Hz

figure
plot(omega,XW)
title('DFT of generated signal with hamming')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
xlim([0 1000])
% plots the DFT of the hammed sum of sinusoid from freq = 0 to freq = 1000

end

