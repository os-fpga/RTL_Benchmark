PIN_DEF = ws2812_ctl.pcf
DEVICE = hx8k

all: $(PROJ).rpt $(PROJ).bin

%.blif: %.v
	yosys -p 'synth_ice40 -top $(PROJ) -json $(PROJ).json -blif $@' $<

%.asc: $(PIN_DEF) %.blif
	nextpnr-ice40 -r --$(DEVICE) --package cb132 --json $(PROJ).json --asc $(PROJ).asc --opt-timing --pcf $(PIN_DEF)

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

%_tb: %_tb.v %.v
	iverilog -o $@ $^

%_tb.vcd: %_tb
	vvp -N $< +vcd=$@

%_syn.v: %.blif
	yosys -p 'read_blif -wideports $^; write_verilog $@'

%_syntb: %_tb.v %_syn.v
	iverilog -o $@ $^ `yosys-config --datdir/ice40/cells_sim.v`

%_syntb.vcd: %_syntb
	vvp -N $< +vcd=$@

sim: $(PROJ)_tb.vcd

postsim: $(PROJ)_syntb.vcd

prog: $(PROJ).bin
	iceprog $<

burn: $(PROJ).bin
	iceFunprog $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo iceprog $<

clean:
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bin $(PROJ).json

.SECONDARY:
.PHONY: all prog clean
