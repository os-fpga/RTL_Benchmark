// Ceil of log base 2
function integer CLogB2;
    input   [31:0] size;
    integer i;
    begin
        i = size;
        for (CLogB2 = 0; i > 0; CLogB2 = CLogB2 + 1)
            i = i >> 1;
    end
endfunction

