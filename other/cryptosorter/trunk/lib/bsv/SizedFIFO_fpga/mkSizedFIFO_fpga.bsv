package mkSizedFIFO_fpga;

import FIFO::*;
import RWire::*;
import RegFile::*;
import IFPGA_FIFO::*;

module mkSizedFIFO_fpga (IFPGA_FIFO#(f_type, size))
  provisos(
            Bits#(f_type, f_type_length),
            Add#(TLog#(size), 0, lg_size),
            Add#(TLog#(size), 1, lg_size_plus),
            Add#(2, TLog#(size),lg_size_plus_plus), 
            Add#(1, lg_size_plus, lg_size_plus_plus)
          );
  
  RegFile#(Bit#(TLog#(size)), f_type) data <- mkRegFile(0, fromInteger(valueof(TSub#(size,1))));
  Reg#(Bit#(lg_size_plus)) number_enqueued <- mkReg(0);
  Reg#(Bit#(TLog#(size))) base_ptr <- mkReg(0);
  RWire#(Bit#(0)) deque_pending <- mkRWire();
  RWire#(Bit#(0)) clear_pending <- mkRWire();
  RWire#(f_type) enque_pending <- mkRWire();

  // We'll have problems with non-saturating additions, so we ought to add some checks
  // Strongly Recommend power of 2 sizes to simpilfy logic.

  rule update;
    if(clear_pending.wget() matches tagged Valid .v)
      begin
        //clear is occuring, we drop a pending enqueue on the floor.
        number_enqueued <= 0;
        base_ptr <= 0;
      end
    else
      begin
       if(enque_pending.wget() matches tagged Valid .new_data)
         begin
           if(deque_pending.wget() matches tagged Valid .dp)
             begin
               // enque and deque occuring.. no change to net.
               base_ptr <= (zeroExtend(base_ptr) == fromInteger(valueof(size)-1))? 0:base_ptr + 1;
               Bit#(lg_size_plus_plus) offset = zeroExtend((zeroExtend(base_ptr) + number_enqueued)); 
               data.upd((offset >= fromInteger(valueof(size)))?
                           truncate(offset - truncate(fromInteger(valueof(size)))):
                          truncate(offset),    
                       new_data);
             end
           else
             begin
               number_enqueued <= number_enqueued + 1;
               Bit#(lg_size_plus_plus) offset = zeroExtend((zeroExtend(base_ptr) + number_enqueued)); 
               data.upd((offset >= fromInteger(valueof(size)))?
                           truncate(offset - truncate(fromInteger(valueof(size)))):
                           truncate(offset),    
                        new_data);
             end
         end 
       else
         begin
           if(deque_pending.wget() matches tagged Valid .dp)
             begin
               //enque and deque occuring.. no change to net.
               base_ptr <= (zeroExtend(base_ptr) == truncate(fromInteger(valueof(size)-1)))? 0:base_ptr + 1;
               number_enqueued <= number_enqueued - 1;
             end
         end 
      end
  endrule

  interface FIFO fifo;

    method Action enq (f_type value) if(number_enqueued < fromInteger(valueof(size)));
      enque_pending.wset(value);
    endmethod

    method Action deq()  if(number_enqueued > 0);
      deque_pending.wset(0);
    endmethod 

    method f_type first() if(number_enqueued > 0);
      return data.sub(base_ptr);
    endmethod 

    method Action clear();
      clear_pending.wset(0);
    endmethod

  endinterface

endmodule
endpackage