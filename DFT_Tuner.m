function [ fo_est,band ] = DFT_Tuner(x,b_E,b_A,b_D,lowpass,highpass)
% Part 5 - Will Cass and Seth Arnold

% DESCRIPTION:
% This function accepts a synthetic guitar signal and filter coefficients.
% The signal is passed though each of the filters.
% The sum square of eached passed signal is calculated.
% The greatest is found. If lowpass or highpass is greatest, the result
% "low" or "high" is returned and nothing else occurs.
% Otherwise, the band is detected, and the DFT is calculated.
% The band is then snipped to be only where the signal lies.
% The DFT and snipped DFT are plotted.
% The frequency is found at which the signal has the highest magnitude
% This frequency is fo_est, the estimated frequency of the input sinusoid

% USEAGE: [fo_est,band] = DFT_Tuner(x,b_E,b_A,b_D,lowpass,highpass)

% INPUTS: This function acceps 6 inputs
% "x" is the generated guitar signal we are "tuning"
% "b_E" is the E passband filter
% "b_A" is the A passband filter
% "b_D" is the B passband filter
% "lowpass" is the lowpass filter used for detecting low out of range
% signals
% "highpass" is the highpass filter used for detecting high out of range
% signals

% OUTPUTS: This function has 2 outputs
% "fo_est" is the estimated frequency of the input sinusoid
% "band" is a string containing the band of the input sinusoid

% PLOTS: 
% Figure 1 - Plots the hammed DFT of the generated signal and the DFT of
% the signal snipped down to only the band the input sinusoid lies within.

Fs = 4410;% sampling rate
Nzp = 100000;% amount of zero padding
N=4410; % number of samples

y_E=filter(b_E,1,x);
y_A=filter(b_A,1,x);
y_D=filter(b_D,1,x);
y_low=filter(lowpass,1,x);
y_high=filter(highpass,1,x);
% reads in filter coefficients found in the Tuner_FIRs function

t_E=sumsqr(y_E);
t_D=sumsqr(y_D);
t_A=sumsqr(y_A);
t_low=sumsqr(y_low);
t_high=sumsqr(y_high);
% sums the square of the filtered signals

if((t_low>t_E)&&(t_low>t_D)&&(t_low>t_A)&&(t_low>t_high))
    band='low_freq';
    fo_est='NaN';
    disp('The signal is out of range.')
    disp('The signal is too LOW.')
    
    
elseif((t_high>t_E)&&(t_high>t_D)&&(t_high>t_A))
    band = 'high_freq';
    fo_est='NaN';
    disp('The signal is out of range.')
    disp('The signal is too HIGH.')
else
% detects whether the highpass or lowpass filtered signal is greatest. 
% if so, fo_est = NaN

if ((t_E>t_D)&&(t_E>t_A)) 
    band = 'E';
elseif ((t_D>t_E)&&(t_D>t_A))
    band = 'D';
elseif((t_A>t_D)&&(t_A>t_E))
    band = 'A';
else
    band = 'no';
end
% detects the band in which the input signal lies

w=hamming(length(x));
w=w';
xw=x.*w;
% creates hamming window and adjusts the input signal

XW=fftshift(fft(xw,length(xw)+Nzp));
magXW=mag2db(abs(XW));
% computes the hammed DFT & converts to dB

omega = ((-(N+Nzp)/2):((N+Nzp)/2))*(pi*2/(N+Nzp));
% Creates "omega" a row vector from -pi radians/sample to pi radians/sample 
% for plotting the DFT against

z=magXW;
z(2,:)=omega;
%creates matrix "z" who's top row contains magnitude values and who's
%bottom row contains the radians/sample value for that magnitude

if(band=='E')
    d=((z(2,:)>.096))&(z(2,:)<.138);
    y=z(:,d);
elseif(band=='A')
    d=(z(2,:)>(.136) & (z(2,:)<.184));
    y=z(:,d);
elseif(band=='D')
    d=((z(2,:)>.181))&(z(2,:)<.24);
    y=z(:,d);
end
% extracting needed portion of the band

[m,i]=max(y(1,:));
% finds "m" the greatest value in row 1 of "y" (the greatest magnitude)
% finds "i" the position of y that contains the greatest magnitude
q=y(2,i);
% finds q the frequency (in radinas/sample) value at i position
fo_est=q*(N)/(2*pi);
% converts radians/sample to Hz

omega = omega*4410/(2*pi);
% Change omega to Hz

figure
subplot(2,1,1)
plot(omega,magXW)
xlim([0 2214])
title('DFT of Generated Signal')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')

y(2,:) = y(2,:)*4410/(2*pi);

subplot(2,1,2)
plot(y(2,:),y(1,:))
title('DFT of Generated Signal - Passband Only')
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')

end

end
