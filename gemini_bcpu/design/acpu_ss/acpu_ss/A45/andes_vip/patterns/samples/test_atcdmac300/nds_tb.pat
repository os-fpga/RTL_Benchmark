initial begin: program_blk

        `ifdef AE350_CONFIG_VH
        `else
                $display("*W The pattern is not supported for AE350 platform");
                $display("%0t:ipipe:---- SIMULATION SKIPPED by configuration checker ----", $time);
                #10 $finish;
        `endif

end
