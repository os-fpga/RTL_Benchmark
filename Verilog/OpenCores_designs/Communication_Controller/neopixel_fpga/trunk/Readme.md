

FPGA Neopixel Device
====================
I was really impressed with the Adafruit Neopixel demo. The rainbow effect looks so nice :).
It cost me around 5 minutes to setup the environment for the Adafruit Neopixel.
While studying the Adafruit Neopixel implementation and the datasheet of the ws2812, 
some things immediately stood out: Assembly for each soc, disabling interrupts to get the 
right timings for each soc shape, etc.

Now I have a reason to buy an oscilloscope to the see the output of the 1-wire.
I experiemented with my own assembly implementation counting the machinecode cycles of 
ATmega328 to setup ws2812 leds over one wire. The protocol has heavy time constraints +-150ns and the the data of 
leds has to transmit one after another (https://cdn-shop.adafruit.com/datasheets/WS2812.pdf).
Here is an example of a 36 foot long neopixel strip https://www.youtube.com/watch?v=I-lR19_kigs.
The conclusion is that it makes no sense for me, since it is not portable. 
To disable interrupts in impeded environments with sensitive application is not ideal.
There are some exceptions, such as the Rasperry Pi which has a real-time implementation 
by using PWM with supported DMA (https://learn.adafruit.com/neopixels-on-raspberry-pi/overview).
Keeping timings conditions on a ATmega328 is feasible but on a CORTEX-A without HW-Support 
running a sensitive application with caches, disabling interrupts is a bit extreme. 
So I started my FPGA hobby project and dove right into FPGA programing and verilog.
My approach is using a SPI to collect 24-RGBs-Strips-Data and a SYNC from a impeded SoC. 
Another approach I came up with is to reuse the Adafruit-Neopixel-Library. 
I attached my FPGA_NeoPixel.h file. Technically it inherits from Adafruit_NeoPixel and overwrites 
the void show() with SPI-Code so you are able to use the methods from Adafruit_Neopixel to set 
leds or calculate color spaces. I have tested it on an Arduiono-Nano but it is easy to 
port the Libs to other SoCs. The only things that matter are the SPI and Neopixel managment.

The implementation is based on an iceFun (ice40-hx8k, https://www.robot-electronics.co.uk/icefun.html). It is easy to port it to another FPGA, 
you only have to specify the frequency and pins. The current implementation is using a 1024-Fifo (ice40-hk8), 
maybe you can even try to control an 1024 strip with it. The possibility to control over 5K with ice40-hx8 (128k/24 ~ 5.3k)
is given. You have only to modify the ADDRESS_LINE parameter of ram_sync in ws2812_ctl.v

A short video shows the result https://www.youtube.com/watch?v=IhsmrSM3q_E of my implementation.

A FPGA has many I/Os just extend it to many 1-wire-outputs to handle more strips in parallel.
I will make my fpga project available on github and if you find the time to take a 
look and tinker with it, I would be grateful for any feedback. 
Some background why I started this project. 

I searched for an open source command based verilog compiler and I found 
Icarus Verilog  (http://iverilog.icarus.com/) + gtkwave from  Stephen Williams. 
In this context I found verilator which is awesome. (https://www.veripool.org/) 
Probably by accident I found the icestorm project by Mr. 
Cliffword and I was so impressed by yosys and arachne-pnr/nextpnr because Synthesis is a domain 
of some companies like synopsis, cadence, mentor graphics with very expensiv license costs. 
In my opinion Mr. Cliffword changed the rules in circuit design (http://opencircuitdesign.com/). 
I am very greatful to him. Now we have compilers for programming languages, 
operating systems and circuit design tools FOSS like - it is so amazing.
