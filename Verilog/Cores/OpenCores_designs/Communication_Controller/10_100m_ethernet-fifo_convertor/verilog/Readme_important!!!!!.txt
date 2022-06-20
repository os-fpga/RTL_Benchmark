
Hi, folks,

I am sorry for the incomplete document and absence of the test files for 
this project.  Here I provide the test cpp program, concise.cpp, by 
connecting the fifo_source and fifo_sink.  In the environment of Linux, run
    g++ -o main concise.cpp
and then
    ./main

When the program is running, then you must be able to know how to operate 
the IP core.

Although the pdf document downloaded is out of date, it can tell out some 
clue on how to design ethernet-fifo convertor. Now both the RxModule and 
TxModule are designed with RAM, so that it consumes lesser resource.

This project has been tested on the hardware designed by myself. I have 
provided the circuit in the appendix of the document. These materials can 
be used directly. If you find something wrong with the codes or have any 
problem, please feel free to contact me.

Sincerely yours,
Renliang Gu
gurenliang@gmail.com
13 Dec. 2009
