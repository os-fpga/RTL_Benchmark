% generate_vhdl_lut()
% This function is a general purpose generator for creating LUTs in VHDL
%
% Description of the arguments:
% lut_name          - String describing the name of the LUT
% input_width_name  - String describing the name of the LUT input wordsize
% input_width       - Input wordsize as integer
% output_width_name - String describing the name of the LUT output wordsize
% output_width      - Output wordsize as integer
% functionhandle    - handle to function to be implemented in LUT, function must have on input argument 
%                     in the value range from 0...input_width-1 producing values in the range 0...output_width-1
% filename          - Filename of the LUT
% filepath          - Path where to store the result
%
% Copyright (C) 2009 Martin Kumm
% 
% This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
% warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License along with this program; 
% if not, see <http://www.gnu.org/licenses/>.

function generate_vhdl_lut(lut_name, input_width_name, input_width, output_width_name, output_width, functionhandle, filename, filepath)
comment = '-- This file is automatically generated by a matlab script \n--\n-- Do not modify directly!\n--\n\n';
vhdl_header = 'library ieee;\nuse ieee.std_logic_1164.all;\nuse IEEE.STD_LOGIC_arith.all;\nuse IEEE.STD_LOGIC_signed.all;\n\n';
package_header = sprintf('package %s_pkg is\n\n',lut_name);
type_definition = sprintf('type lut_type is array(0 to 2**(%s-2)-1) of std_logic_vector(%s-1 downto 0);\n\n',input_width_name,output_width_name);
lut_def_start = sprintf('	constant %s : lut_type := (\n',lut_name);
lut_def_end = '	);\n\n';


vhdl_end = sprintf('end %s_pkg;\n\npackage body %s_pkg is\nend %s_pkg;',lut_name,lut_name,lut_name);
constant_definitions = sprintf('constant %s : integer := %d;\nconstant %s : integer := %d;\n\n',input_width_name, input_width,output_width_name, output_width);

filename = sprintf('%s/%s_%d_x_%d.vhd',filepath,filename,input_width,output_width);
disp(['Generating LUT using output file ',filename])

fid=fopen(filename,'w+');
if(fid ~= -1)
    fprintf(fid, comment);
    fprintf(fid, vhdl_header);
    fprintf(fid, package_header);
    fprintf(fid, constant_definitions);
    fprintf(fid, type_definition);
    fprintf(fid, lut_def_start);

    for i=1:2^(input_width-2)-1
        fprintf(fid, '    conv_std_logic_vector(%d,%s),\n',round((2^(output_width-1)-1)*functionhandle(i)),output_width_name);
    end;
    fprintf(fid, '    conv_std_logic_vector(%d,%s)\n',round((2^(output_width-1)-1)*functionhandle(i)),output_width_name);

    fprintf(fid, lut_def_end);
    fprintf(fid, vhdl_end);


    fclose(fid);
else
    disp('Error: could not open file');
end;
