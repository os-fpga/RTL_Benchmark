in this directory, i will put assembly programs.
put corresponding "_init_ram.txt" in /sim directory for VHDL simulation

=============================================================
HPC-16 Assembler
-------------------
HPC-16 Assembler written in python, so to run it you will need to install Python 2.7.
also it will requires following python module:

antlr4-python2-runtime 

(for both linux & windows)
pip install antlr4-python2-runtime


usage: 

./HPC16_asm.py <input_file>

generates

1) *_init_ram.txt       --- For VHDL simulation 
2) *_asm_out.txt        --- For Debugging



TODO:
assembler is very basic. need to add more features


The antlr4 grammar file (HPC16.g4) is also committed. 

basic setup is following

export CLASSPATH=".:/antlr_jar_path/antlr-4.5.1-complete.jar:$CLASSPATH"

java -jar /antlr_jar_path/antlr-4.5.1-complete.jar -Dlanguage=Python2 HPC16.g4

See further info at http://www.antlr.org

=====================================================================================


