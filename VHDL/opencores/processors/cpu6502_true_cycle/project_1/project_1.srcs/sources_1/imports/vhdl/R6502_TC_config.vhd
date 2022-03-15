-- Generation properties:
--   Format              : flat
--   Generic mappings    : exclude
--   Leaf-level entities : direct binding
--   Regular libraries   : use work
--   View name           : include
--   
library work;
configuration R6502_TC_config of R6502_TC is
   for struct
      for all : Core
         use entity work.Core(struct);
         for struct
            for all : FSM_Execution_Unit
               use entity work.FSM_Execution_Unit(fsm);
            end for;
            for all : FSM_NMI
               use entity work.FSM_NMI(fsm);
            end for;
            for all : RegBank_AXY
               use entity work.RegBank_AXY(struct);
               for struct
               end for;
            end for;
            for all : Reg_PC
               use entity work.Reg_PC(struct);
               for struct
               end for;
            end for;
            for all : Reg_SP
               use entity work.Reg_SP(struct);
               for struct
               end for;
            end for;
         end for;
      end for;
   end for;
end R6502_TC_config;
