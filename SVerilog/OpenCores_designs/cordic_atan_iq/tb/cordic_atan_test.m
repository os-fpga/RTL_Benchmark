clc

I = 20e6;
Q = 4e6;

[angle, isqrt] = cordic_atan_iq(20e6, 4e6);
a = atan(Q/I) * 180 / pi;
iq_sqrt = int32(sqrt(I^2 + Q^2));
delta = iq_sqrt - isqrt;

fprintf('\nAngle MatLab: %g, Cordic: %g; SQRT MatLab: %d, Cordic: %d, delta %d\n', a, angle, iq_sqrt, isqrt, delta);
