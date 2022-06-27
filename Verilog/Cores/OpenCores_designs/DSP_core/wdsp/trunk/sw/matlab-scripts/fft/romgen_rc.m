function romgen_rc(rp,fp,tbits,rnum) 
%   romgen_rc(rp,fp,tbits) 
%        rp= number of points in this rom 
%       fp= total number of points in the FFT. 
%       tbits=width of the twiddle factor 
%       rnum=rom number 
%        
%    This function creates the vhdl ROM file used to store the twiddle fac tors. 
%       The  resulting file is named rom<rnum>.vhdl, where <rnum> is the value specifi ed in rp. 
%       For exa mple: romgen_rc(16,64,10,1) would create a file called rom1.vhdl 
% 
%        This program uses: 
%           frac2bin.m  
%           writ ebin.m  
 
%opening file for writing , (modified by Alex-Parrado)
fname=sprintf('../../../rtl/vhdl/WISHBONE_FFT/rom%d.vhd',rnum); 
fprintf('creating file %s\n',fname); 
fid=fopen(fname,'w'); 
%writing beginning stuff to the file 
aw=log2(rp); 
fprintf(fid,'-- Rom file for twiddle factors \n'); 
fprintf(fid ,'-- %s',fname);  
fprintf(fid,' contains %d points of %d width \n',rp,tbits); 
fprintf(fid,'--  for a %d point fft.\n\n',fp); 


  
%Synchronous ROM modification by Alex-Parrado
fprintf(fid,'LIBRARY ieee;\nUSE ieee.std_logic_1164.ALL;\nUSE ieee.std_logic_arith.ALL;\n'); 
fprintf(fid,'\n\nENTITY rom%d IS\n         GENERIC(\n',rnum); 
fprintf(fid,'        data_width : integer :=%d;\n',tbits); 
fprintf(fid,'        address_width : integer :=%d\n',aw); 
fprintf (fid,'    );\n    PORT(\n'); 
fprintf(fid,'        clk :in std_logic;\n'); 
fprintf(fid,'        address :in std_logic_vector (%d      downto 0);\n',aw-1); 
fprintf(fid ,'        datar : OUT std_logic_vector (data_width-1 DOWNTO 0) ;\n'); 
fprintf(fid,'        datai : OUT std_logic_vector (data_width-1 DOWNTO 0)\n    );\n');  
fprintf(fid,'end rom%d;\n',rnum); 
%begin writing architecture 
fprintf(fid,'ARCHITECTURE behavior OF rom%d IS\n\n BEGIN\n\n',rnum); 
fprintf(fid,'process (address,clk)\nbegin\n    	if(rising_edge(clk)) then \n case address is\n'); 
ma=fp/rp*[2 1 3]; 
address=0; 
for m=1:3 
    for n=0:((rp/4)-1) 
%          fprintf('%d %d %d %d %d',n,m,ma(m),rp,fp); 
        expval=exp(-2*pi* j*n*ma(m)/fp); 
      rscld=round(real(expval)*(2^(tbits-1)-1));     
       iscld=round(imag(expval)*(2^(tbits-1)-1)); 
        bitvecr=frac2bin(rscld,tbits,0); 
        bitveci=frac2bin(iscld,tbits,0); 
         addrvec=dec2bin(address,aw); 
        fprintf(fid,'        when "%s" => datar <= "',addrvec); 
        writebin( fid,bitvecr); 
      fprintf(fid,'";datai <= "'); 
         writebin(fid,bitveci); 
          fprintf(fid,'"; --%d\n',n*ma(m)); 
         address=address+1; 
    end 
end 
%filling out the remaining zeros 
bitvecr=frac2bin((2^(tbits-1)-1),tbits,0); 
bitveci=frac2bin(0,tbits,0); 
for n=0:(rp/4-1) 
    addrvec=dec2bin(address,aw); 
    fprintf(fid,'           when "%s" => datar <= "',addrvec); 
    writebin(fid,bitvecr); 
    fprintf(fid,'";datai <= "'); 
    writebin(fid,bitveci); 
    fprintf(fid,'"; --0\n'); 
    address=address+1; 
end 
 
fprintf(fid,'        when others => for i in data_width-1 downto 0 loop\n'); 
fprintf(fid,'            datar(i)<=''0'';datai(i)<=''0'';end loop;\n'); 
fprintf(fid,'    end case;\n\n'); 
fprintf(fid,'    end if;\n\n'); 
fprintf(fid,'end process;\nEND behavior;\n'); 
fclose(fid); 
