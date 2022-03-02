function wb_gen(NET)

[wbMat NLayers] = getwbc(NET);
MaxNeuronCnt = max_dim(wbMat);

fileid = fopen ('wb_init.vhd','w');

% addr weights:
% |_ _|  |0|  |_ _ _ _ _| |_ _ _ _ _ _|
% layer  bias    neuron      input
% *2^12+  0   + *2^5    +   *2^0
% addr biases:
% |_ _|  |1|  |0 0 0 0 0 0| |_ _ _ _ _|
% layer  bias                 neuron
% *2^12+ 2^11 +     0      +   *2^0

fprintf(fileid,'library ieee;\n');
fprintf(fileid,'use ieee.std_logic_1164.all;\n');
fprintf(fileid,'use ieee.numeric_std.all;\n');
fprintf(fileid,'library work;\n');
fprintf(fileid,'use work.support_pkg.all;\n');
fprintf(fileid,'use work.layers_pkg.all;\n');
fprintf(fileid,'package wb_init is\n');

fprintf(fileid,'  type ramd_type is array (%i downto 0) of std_logic_vector(NbitW-1 downto 0);\n',MaxNeuronCnt);
fprintf(fileid,'  type layer_ram is array (%i downto 0) of ramd_type;\n',MaxNeuronCnt);
fprintf(fileid,'  type w_ram  is array (integer range <>) of layer_ram;\n');
fprintf(fileid,'  type b_type is array (integer range <>) of ramd_type;\n');

fprintf(fileid,'  constant w_init : w_ram :=\n');
fprintf(fileid,'  (\n');
for(k=1:NLayers)
  fprintf(fileid,'    %i => (\n',k-1);
  for(i=1:size(cell2mat(wbMat(k,1)),2))  % neurons 
    fprintf(fileid,'      %i => (\n',i-1);
    for(j=1:size(cell2mat(wbMat(k,1)),1))    % inputs 
      fprintf(fileid,'        %i => real2stdlv(NbitW,%1.4f)',j-1, cell2mat(wbMat(k,1))(j,i));
      if j ~= size(cell2mat(wbMat(k,1)),1)
        fprintf(fileid,',\n');
      else
        fprintf(fileid,',\n        others =>(others => ''0'')\n');
      end;
    end;
    if i ~= size(cell2mat(wbMat(k,1)),2)
      fprintf(fileid,'      ),\n');
    else
      fprintf(fileid,'      ),\n      others=>(others =>(others => ''0''))\n');
    end;
  end;
  if k ~= NLayers
    fprintf(fileid,'    ),\n');
  else
    fprintf(fileid,'    )\n');
  end;
end;
fprintf(fileid,'  );\n\n');

fprintf(fileid,'  constant b_init : b_type :=\n');
fprintf(fileid,'  (\n');
for(k=1:NLayers)
  fprintf(fileid,'    %i => (\n',k-1);
  for(j=1:length(cell2mat(wbMat(k,2))))    % inputs 
    fprintf(fileid,'      %i => real2stdlv(NbitW,(2.0**LSB_OUT)*(%1.4f))',j-1, cell2mat(wbMat(k,2))(j));
    if j ~= length(cell2mat(wbMat(k,2)))
      fprintf(fileid,',\n');
    else
      fprintf(fileid,',\n      others =>(others => ''0'')\n');
    end;
  end;
  if k ~= NLayers
    fprintf(fileid,'    ),\n');
  else
    fprintf(fileid,'    )\n');
  end;
end;
fprintf(fileid,'  );\n');

fprintf(fileid,'end wb_init;\n');
fclose(fileid); 