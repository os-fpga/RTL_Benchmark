
function [angle, isqrt] = cordic_atan_iq(IS, QS);

IS = int32(IS);
QS = int32(QS);

tg = double(QS) / double(IS);
atg = atan(tg) / pi * 180;
fprintf('Given I = %g, Q = %g, angle = %g degree\n', IS, QS, atg);

sign = IS < 0;
if sign
    IS = -IS;
    QS = -QS;
end

% [F Exp_I] = log2(double(IS));
% [F Exp_Q] = log2(double(QS));
% 
% Exp_I
% Exp_Q
% 
% E = max(Exp_I, Exp_Q) + 1;
% 
% IS = int32(IS * 2^(31 - E));
% QS = int32(QS * 2^(31 - E));

fprintf('I = 0x%08x, Q = 0x%08x\n', IS, QS);

i = 0;
atan_table(1) = int32(1);

while i == 0 || atan_table(i) ~= 0
    atan_table(i+1) = int32(2^30 * atan(1/2^i) / (pi/2));
    i = i + 1;
end

k = 1;
for i=1:length(atan_table)
   k = k * 1 / sqrt(1 + 2^(-2 * (i-1)));
end

x(1) = IS;
y(1) = QS;
a(1) = int32(0);

tg = double(y(1)) / double(x(1));
atg = atan(tg) / pi * 180;
fprintf('i = %d: x = %d, y = %d (%g deg), a = %d(%g degree)\n', 0, x(1), y(1), atg, a(1), double(a(1))/2^30 * 90);

for i=2:length(atan_table) % i dont use last table element
    if y(i-1) > 0
        x(i) = x(i-1) + y(i-1) / 2^(i-2);
        y(i) = -x(i-1) / 2^(i-2) + y(i-1);
        a(i) = a(i-1) - atan_table(i-1);
        fprintf('i = %d: rot = %g deg, ', i-1, -double(atan_table(i-1)) / 2^30 * 90);
    else
        x(i) = x(i-1) - y(i-1) / 2^(i-2);
        y(i) = x(i-1) / 2^(i-2) + y(i-1);
        a(i) = a(i-1) + atan_table(i-1);
        fprintf('i = %d: rot = %g deg, ', i-1, double(atan_table(i-1)) / 2^30 * 90);
    end
    
    tg = double(y(i)) / double(x(i));
    atg = atan(tg) / pi * 180;    
    fprintf('x = %d, y = %d (%g deg), a = %d(%g deg)\n', x(i), y(i), atg, a(i), double(a(i))/2^30 * 90);
end

angle = -double(a(end))/2^30 * 90;
if sign
    if angle > 0
        angle = angle - 180;
    else
        angle = angle + 180;
    end
end

isqrt = int32(k * double(x(end)));

end
