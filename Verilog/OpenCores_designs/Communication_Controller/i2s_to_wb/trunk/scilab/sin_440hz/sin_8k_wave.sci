
N = 0 : 88200;
Fs = 44100;
f = 440;
x = 2 * %pi * (f / Fs) * N; 

y = sin(x); 

plot(x, y); 

y_transpose = y';

wn = y_transpose / max(abs(y_transpose)); 

Ws = [wn ; wn];

wavwrite(Ws, Fs, 'first_wave.wav');
