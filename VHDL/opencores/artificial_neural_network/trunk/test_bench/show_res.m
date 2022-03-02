y_tb = load('data_out_tb.txt');
plot(y_tb./256,'b');
hold on;
y_oct = load('data_out_oct.txt');
plot(y_oct,'r');
title('results from octave vs results from ghdl test bench')
legend({"results from ghdl","results from octave"})

disp('press any key to continue');

pause;
