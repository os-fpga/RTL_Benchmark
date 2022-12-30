function y = IntToBit32(x)
% double to bit32
    y = typecast(int32(round(x)), 'uint32');
end