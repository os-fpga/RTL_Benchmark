function c = W(k, N)
%     if mod(k, N) == 0 return 1;
    arg = -2 * pi * k / N;
    Re = cos(arg);
    Im = sin(arg);
    c = complex(Re, Im);
end

