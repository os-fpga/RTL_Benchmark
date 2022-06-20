clear all;
format long g;


%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
%                       filtro_FIR.vhd
%XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
% http://t-filter.appspot.com/fir/index.html

fs=64e6
order=31                
fc=2e6               
input_size=8

%%%%%%%%%%%%%%%%%%%% h[n] %%%%%%%%%%%%%%%%%%%%%%%%%

fnyquist=fs/2;

%normalized cut-off frequency
wn=fc/fnyquist;

h= fir1(order,wn,'low') 			

figure(1);
stem(h);
title('h(n)');grid on;


%%%%%%%%%%%%%%%%%%%% H[z] %%%%%%%%%%%%%%%%%%%%%%%%%

figure(2);
freqz(h);

%%%%%%%%%%%%%%%%%%%% x[n] %%%%%%%%%%%%%%%%%%%%%%%%%

num_cycles=16;
amplitude=2^input_size-1;  
freq=fc/4;

num_samples=num_cycles*(fs/freq);

n=0:1/(fs/freq):num_cycles;
sin=amplitude*sin(2*pi*n);
x=sin+(amplitude/20)*randn(size(n)); 

figure(3);
subplot(2,2,1); 
str=sprintf('x[n]:  f=%g Hz  max=%g+noise',freq,max(sin));
stem(x); title(str); grid on;

%%%%%%%%%%%%%%%%%%%% x[z] %%%%%%%%%%%%%%%%%%%%%%%%%

% NFFT = 2^nextpow2(num_samples);
% f = (1:NFFT/2+1)*(fs/NFFT);          % wn=1 <> fs/2 

% X = fft(x,NFFT);
% peakpowerX = max(X).*conj(max(X))/NFFT;      

subplot(2,2,2);
% stem(f,2*abs(X(1:NFFT/2+1))); 
% str=sprintf('x[z]  peak power=%g',peakpowerX);
% title(str); grid on;
% xlabel('f[Hz]')
% ylabel('|x[z]|')
periodogram(x,rectwin(length(x)),length(x),fs);


% %%%%%%%%%%%%%%%%%%%% y[n] %%%%%%%%%%%%%%%%%%%%%%%

y=filter(h,1,x);
subplot(2,2,3); 
str=sprintf('y[n]:  fc=%g Hz  peak=%g',fc,max(y(length(h):num_samples)));
stem(y); title(str); grid on;

%%%%%%%%%%%%%%%%%%%% y[z] %%%%%%%%%%%%%%%%%%%%%%%%%
 
subplot(2,2,4);
periodogram(y,rectwin(length(y)),length(y),fs);


format;


