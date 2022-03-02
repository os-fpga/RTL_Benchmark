function N = max_dim(CA)
% largest neuron count in layer
N = 0;
for (i=1:size(CA,1))
  N = max(N, max(size(cell2mat(CA(i,1)))));
end;
