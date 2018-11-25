function [ b_E,b_A,b_D,lowpass,highpass] = Tuner_FIRs()
% Part 5 Filters - Seth Arnold and Will Cass

% DESCRIPTION:
% Generates 5 filters for use in DFT_Tuner
% Uses firpmord and firpm to generate the filters in the Parks-McClellan procedure

% USEAGE: [ b_E,b_A,b_D,lowpass,highpass] = Tuner_FIRs()

% INPUTS: This function acceps no inputs

% OUTPUTS: This function has 5 outputs
% "b_E" is the E passband filter
% "b_A" is the A passband filter
% "b_D" is the B passband filter
% "lowpass" is the lowpass filter used for detecting low out of range
% signals
% "highpass" is the highpass filter used for detecting high out of range
% signals

rp=1;
% passband ripple (dB)

rs=60;
% stop band attenuation (dB)

[N,fo,ao,w]=firpmord([59 68 96 105],[0 1 0],[10^(-rs/20) (10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)],[4410]);
b_E=firpm(N,fo,ao,w);
% creates filter for E band
% firpmord accepts details about the filter we want
% such as where to transition, in Hz, the type of band, shown by order of
% ones and zeroes, the specifications for frequency in these different
% bands and the sampling rate this filter is for
% firpmord then returns values which will be used for our firpm filter
% number of generated coefficients is under 1000

[N,fo,ao,w]=firpmord([87 96 128 138],[0 1 0],[10^(-rs/20) (10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)],[4410]);
b_A=firpm(N,fo,ao,w);
% creates filter for A band in the same way

[N,fo,ao,w]=firpmord([119 128 166 175],[0 1 0],[10^(-rs/20) (10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)],[4410]);
b_D=firpm(N,fo,ao,w);
% creates filter for D band in the same way

[N,fo,ao,w]=firpmord([67 77],[1 0],[10^(-rs/20) (10^(rp/20)-1)/(10^(rp/20)+1)],[4410]);
lowpass=firpm(N,fo,ao,w);
% creates filter for lowpass band in the same way

[N,fo,ao,w]=firpmord([156 166],[0 1],[(10^(rp/20)-1)/(10^(rp/20)+1) 10^(-rs/20)],[4410]);
highpass=firpm(N,fo,ao,w);
% creates filter for highpass band in the same way

end

