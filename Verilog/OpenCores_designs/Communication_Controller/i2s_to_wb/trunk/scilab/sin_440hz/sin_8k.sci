//
//  get one cycle of 440khz data for rom;
// 

Fs = 8192;
f = 440;

samples_per_wavelength = ceil( (1/f)/(1/Fs) );

N = 0 : samples_per_wavelength;
x = 2 * %pi * (f / Fs) * N; 

y = sin(x); 

// plot(x, y);

y_transpose = y';

wn = y_transpose / max(abs(y_transpose)); 

wn = wn * ((2^32) / 2);

wn = round( wn );



u=file('open','sin_8k_rom.txt','unknown') //open the result file

for i = 1:(samples_per_wavelength + 1), fprintf( u, '@%8.8x\n %8.8x\n\n', i, wn(i) ), end

file('close',u) //close the result file



