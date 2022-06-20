% New IQ Correction algorithm, yet the third one
close all;
clear all;
e1 = 0.1; %gain error

%phase error
a1 = 10*pi/180; 
%a1 = -10*pi/180;

%original noise
sgma = 0.01; %noise sigmage

%original sample length
%n_dat = 250000; % number of samples
n_dat = 100000; % number of samples

freq = 0.03;  % relative frequency

amplitude = 1;

%in phase signal, or I
x1=amplitude*cos(2*pi*(0:n_dat-1)*freq)+sgma*randn(1,n_dat);

%quadrature signal, or Q
y1=amplitude*(1+e1)*sin(2*pi*(0:n_dat-1)*freq+a1) + sgma*randn(1,n_dat);

reg_1 = 0;
reg_2 = 1;

%original mu
%mu_1 = 0.0002;
%mu_2 = 0.0001;

%mu adjusted to closest powers of two in order to match VHDL implementation
mu_1 = 0.000244;
mu_2 = 0.000122;


y2=zeros(1,n_dat);
y3=zeros(1,n_dat);
reg_1_sv = zeros(1,n_dat);
reg_2_sv = zeros(1,n_dat);










I_data = fopen('I_data_octave', 'w+t', 'native');
Q_data = fopen('Q_data_octave', 'w+t', 'native');

phase_estimate = fopen('phase_error_estimate_octave', 'w+t', 'native');
gain_estimate = fopen('gain_error_estimate_octave', 'w+t', 'native');



for nn=1:n_dat
    y2(nn) = y1(nn)-reg_1*x1(nn);
    reg_1_sv(nn) = reg_1;
    reg_1 = reg_1 + mu_1*x1(nn)*y2(nn);

    fprintf (I_data, '%f\r\n', x1(nn));
    fprintf (Q_data, '%f\r\n', y1(nn));
    fprintf (phase_estimate, '%f\r\n', reg_1);
    
    y3(nn) = y2(nn)*reg_2;
    reg_2_sv(nn) = reg_2;
    
    %original reg_2
    %reg_2 = reg_2+mu_2*(abs(x1(nn))^2 - abs(y3(nn))^2);

    %proposed reg_2
    reg_2 = reg_2+mu_2*((x1(nn))^2 - (y3(nn))^2);
    fprintf (gain_estimate, '%f\r\n', reg_2);
end


fclose(I_data);
fclose(Q_data);

fclose(phase_estimate);
fclose(gain_estimate);





figure(1)
subplot(2,1,1);
plot(reg_1_sv);
hold on;
plot([0 n_dat], [1 1]*a1*(1+e1), 'r');
hold off;
grid on;
title('Phase Error Estimate Trajectory')

subplot(2,1,2)
plot(reg_2_sv);
hold on

%original plot
%plot([0 n_dat], [1.0 1.0]/(1.0+e1), 'r');

%proposed plot
plot([0 n_dat], [1.0 1.0]/((1.0+e1)*(cos(a1))), 'r');
hold off
grid on
title('Gain Error Estimate Trajectory')
%added following line to make pngs
print("figure1_longer.png", "-dpng")

figure(2)
subplot(1,3,1)
plot(x1,y1)
hold on
plot(x1,y1,'r.')
plot([1 1 -1 -1 1],[1 -1 -1 1 1],'-r')
hold off
grid on
axis('square')
axis([-1.2 1.2 -1.2 1.2])
title('Lissajou Diagram, Gain & Phase Offset')

subplot(1,3,2)
plot(x1, y2)
hold on
plot(x1,y2, 'r.')
plot([1 1 -1 -1 1],[1 -1 -1 1 1],'-r')
hold off
grid on
axis('square')
axis([-1.2 1.2  -1.2 1.2])
title('Lissajou Diagram, Phase Offset Corrected')

subplot(1,3,3)
plot(x1, y3)
hold on
plot(x1,y3, 'r.')
plot([1 1 -1 -1 1],[1 -1 -1 1 1],'-r')
hold off
grid on
axis('square')
axis([-1.2 1.2  -1.2 1.2])
title('Lissajou Diagram, Gain & Phase Offset Corrected')

%added following line to make pngs
print("figure2_longer.png", "-dpng")

figure(3)
subplot(3,1,1)

%original MATLAB code used kaiser window function
%is commented out in this section.
%kaiser is in the package octave-windows
%this package turned out to be hard to install
%kaiser was replaced with blackman-harris window function.
%ww=kaiser(1024,12)';

ww=blackman(1024)';


ww=ww/sum(ww);
tt=n_dat-1023:n_dat;
plot(-0.5:1/1024:0.5-1/1024,fftshift(20*log10(abs(fft((x1(tt)+1i*y1(tt)).*ww)))))
% z=zeros(1,1024);
% for kk=1:1024
%    z(kk)=(x1(tt(kk))+1i*y1(tt(kk)))*ww(kk);
% end
% plot(-0.5:1/1024:0.5-1/1024,fftshift(20*log10(abs(fft(z)))))
grid on
axis([-0.5 0.5 -140 10])
title('Output Spectrum with Gain and Phase Offset')

subplot(3,1,2)
tt=n_dat-1023:n_dat;
% z=zeros(1,1024);
% for kk=1:1024
%     z(kk)=(x1(tt(kk))+1i*y2(tt(kk)))*ww(kk);
% end
% plot(-0.5:1/1024:0.5-1/1024,fftshift(20*log10(abs(fft(z)))));
plot(-0.5:1/1024:0.5-1/1024,fftshift(20*log10(abs(fft((x1(tt)+1i*y2(tt)).*ww)))))
grid on
axis([-0.5 0.5 -140 10])
title('Output Spectrum with Phase Offset Corrected')

subplot(3,1,3)
tt=n_dat-1023:n_dat;
% z=zeros(1,1024);
% for kk=1:1024
%     z(kk)=(x1(tt(kk))+1i*y3(tt(kk)))*ww(kk);
% end
% plot(-0.5:1/1024:0.5-1/1024,fftshift(20*log10(abs(fft(z)))));
plot(-0.5:1/1024:0.5-1/1024,fftshift(20*log10(abs(fft((x1(tt)+1i*y3(tt)).*ww)))))
grid on
axis([-0.5 0.5 -140 10])
title('Output Spectrum with Gain & Phase Offset Corrected')

%added following line to make pngs
print("figure3_longer.png", "-dpng")

disp('last reg_1 is ')
reg_1
disp('last reg_2 is ')reg_2