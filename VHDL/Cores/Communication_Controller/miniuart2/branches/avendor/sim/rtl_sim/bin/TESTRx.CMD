| Script file for testing the receiver
| for multi frames
 
| Initial settings
delete_waveforms
restart 
stepsize 50nS
 
| Watched Signals and Vectors
watch WB_CLK_I | Wishbone clock
watch WB_RST_I
watch WB_WE_I
watch WB_STB_I
watch WB_ACK_O
vector WB_ADR ADR_I[1:0]
vector WB_DI DAT_I[7:0]
vector WB_DO DAT_O[7:0]
watch RxD	| RS232 Rx Line
watch IntRx	| Emit Buffer is empty
watch BRClk
watch EnabRx

| Stimulators Assignment
| 1/Read SReg
| 2/Read Byte Rx
| 3/Read SReg
| 4/Read Byte Rx
clock WB_CLK_I	1 0
wfm WB_RST_I	@1nS=L 100nS=H 100nS=L
wfm WB_STB_I	@1nS=L +
            	@190.001uS=H 100nS=L +
				@200.001uS=H 100nS=L +
	            @210.001uS=H 100nS=L +
				@355.501uS=H 100nS=L
wfm WB_WE_I		@1nS=L +
	            @190.001uS=L +
    	        @200.001uS=L +
        	    @210.001uS=L +
            	@355.501uS=L
wfm WB_ADR		@1nS=L +
        	    @190.001uS=1\H 100nS=Z +
				@200.001uS=0\H 100nS=Z +
           		@210.001uS=1\H 100nS=Z +
            	@355.501uS=0\H 100nS=Z

wfm BRClk  @0nS=L (1uS=H 1uS=L)*8000 | Baud rate
| Below is a generation of 50 same frames, coding 40h. 
wfm RxD    @0nS=H +
           102.7uS=H (8uS=L 8uS=L 8uS=L 8uS=L 8uS=L 8uS=L 8uS=L 8uS=H 8uS=L 8uS=H)*50 8uS=H

| Perform Simulation
sim 4000uS

