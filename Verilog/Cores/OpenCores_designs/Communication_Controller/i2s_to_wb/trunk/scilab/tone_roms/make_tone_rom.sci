function [g] = make_tone_rom( tone_freq, sample_freq )

// Ouput variables initialisation (not found in input variables)
g=[];

// Number of arguments in function call
[%nargout,%nargin] = argn(0)

// Display mode
mode(0);

// Display warning for floating point exception
ieee(1);


// Fs = 8192;
// f = 440;
Fs = sample_freq;
f = tone_freq;

samples_per_wavelength = ceil( (1/f)/(1/Fs) );

N = 0 : samples_per_wavelength;
x = 2 * %pi * (f / Fs) * N; 

y = sin(x); 

y_transpose = y';

wn = y_transpose / max(abs(y_transpose)); 

wn = wn * ((2^31) / 10); // leave one bit for sign and scale 

wn = round( wn );


file_name = 'tone_' +  string( tone_freq ) + '_at_' + string( sample_freq ) +  'sps_rom.txt';

u=file('open', file_name, 'unknown') //open the result file

for i = 1:(samples_per_wavelength + 1), fprintf( u, '@%8.8x\n %8.8x\n\n', (i - 1), wn(i) ), end

file('close',u) //close the result file


endfunction

