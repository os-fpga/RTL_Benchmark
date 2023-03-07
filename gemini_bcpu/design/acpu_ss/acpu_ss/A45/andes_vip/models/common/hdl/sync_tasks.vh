


parameter MODEL_ID = 1;
parameter MAX_MODEL_DATA = 8;
parameter SYNC_STATUS_BASE = 1000;


event		sync_model_trigger;
event		sync_tb_trigger;
event		sync_model_error;
reg [31:0]	sync_data[0:MAX_MODEL_DATA-1];
reg		sync_program_done;
reg [31:0]	sync_program_status;


initial begin
	sync_program_done = 1'b0;
	sync_program_status = 32'h0;
end


task set_sync_data;
input [31:0] index;
input [31:0] value32;
begin
	if (index >= MAX_MODEL_DATA) begin
		$display("%0t:%m:ERROR:index = %0d is out of range (0 ~ %0d)", $time, index, MAX_MODEL_DATA - 1);
		program_exit('d1);
	end
	else
		sync_data[index] = value32;
end
endtask


task get_sync_data;
input [31:0] index;
output [31:0] value32;
begin
	if (index >= MAX_MODEL_DATA) begin
		$display("%0t:%m:ERROR:index = %0d is out of range (0 ~ %0d)", $time, index, MAX_MODEL_DATA - 1);
		program_exit('d2);
	end
	else
		value32 = sync_data[index];
end
endtask


task model_trigger;
begin
	->sync_model_trigger;
end
endtask


task tb_trigger;
begin
	->sync_tb_trigger;
end
endtask


task wait_model_trigger;
begin
	@(sync_model_trigger) ;
end
endtask


task wait_tb_trigger;
begin
	@(sync_tb_trigger) ;
end
endtask


task wait_model_error;
begin
	@(sync_model_error) ;
end
endtask


task wait_program_done;
begin
	wait (sync_program_done) ;
end
endtask


task set_program_status;
input [31:0] status32;
begin
	sync_program_status = SYNC_STATUS_BASE + status32;
end
endtask


task get_program_status;
output [31:0] status32;
begin
	status32 = sync_program_status;
end
endtask


task program_exit;
input [31:0] status32;
begin
	if (status32 !== 32'd0) begin
		sync_program_status = SYNC_STATUS_BASE + status32;
		->sync_model_error;
	end

	sync_program_done = 1'b1;
end
endtask


initial begin:HAL_URAREG_dummy_reference_in_sync_tasks
        integer i;
        reg unused_wires;
        for (i = 0; i < MAX_MODEL_DATA; i = i + 1) begin
                sync_data[i] = 32'bx;
        end

        unused_wires = 1'b0;
        for (i = 0; i < MAX_MODEL_DATA; i = i + 1) begin
                unused_wires = unused_wires | (|sync_data[i]);
        end
end

