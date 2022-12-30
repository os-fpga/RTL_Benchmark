// Full Adder: adds three 1-bit numbers
module fa(
            input        a,
            input        b,
            input        ci, // Carry Input

            output logic co, // Carry Output
            output logic s // Sum
            );

   logic                 d,e,f;

   xor(s,a,b,ci);
   and(d,a,b);
   and(e,b,ci);
   and(f,a,ci);
   or(co,d,e,f);
endmodule