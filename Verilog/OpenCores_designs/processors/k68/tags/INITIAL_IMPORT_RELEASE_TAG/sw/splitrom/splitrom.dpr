/////////////////////////////////////////////////////////////////////
////                                                             ////
//// Copyright (C) 2003 to Shawn Tan Ser Ngiap.                  ////
////                       shawn.tan@aeste.net                   ////
////                                                             ////
//// This source file may be used and distributed without        ////
//// restriction provided that this copyright statement is not   ////
//// removed from the file and that any derivative work contains ////
//// the original copyright notice and the associated disclaimer.////
////                                                             ////
////     THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY     ////
//// EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED   ////
//// TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS   ////
//// FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR      ////
//// OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,         ////
//// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES    ////
//// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE   ////
//// GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR        ////
//// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF  ////
//// LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT  ////
//// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT  ////
//// OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE         ////
//// POSSIBILITY OF SUCH DAMAGE.                                 ////
////                                                             ////
/////////////////////////////////////////////////////////////////////

program splitrom;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes;

var
  fin,f0,f1,f2,f3:tfilestream;
  dat: cardinal;
  i,l:integer;
begin
  { TODO -oUser -cConsole Main : Insert code here }
  if paramcount <> 1 then begin
	writeln('Syntax: splitrom <binary ROM filename>');
	halt;
  end;

  if not fileexists(paramstr(1)) then begin
	writeln('File ',paramstr(1),' not found!');
	halt;
  end;

  fin := tfilestream.create(paramstr(1),fmopenread);

  f0 := tfilestream.create(changefileext(paramstr(1),'.0.bin'),fmcreate);
  f1 := tfilestream.create(changefileext(paramstr(1),'.1.bin'),fmcreate);
  f2 := tfilestream.create(changefileext(paramstr(1),'.2.bin'),fmcreate);
  f3 := tfilestream.create(changefileext(paramstr(1),'.3.bin'),fmcreate);

  try
	l := sizeof(dat);
	repeat
		dat := 0;
		i := fin.Read(dat,l);

		f0.Write(byte(dat),1);
		dat := dat shr 8;
		f1.Write(byte(dat),1);
		dat := dat shr 8;
		f2.Write(byte(dat),1);
		dat := dat shr 8;
		f3.Write(byte(dat),1);

	until i<l;

  finally
	fin.free;
	f0.free;
	f1.free;
	f2.free;
	f3.free;
  end;
end.

