function [wb N_layers] = getwbc(NET)
% save neural network's weigths
% and biases in a cell array

N_layers = NET.numLayers;

wb = cell(N_layers,2);

wb(1,1) = cell2mat(NET.IW(1,1));
wb(1,2) = cell2mat(NET.b(1));

for(i=2:N_layers)
  wb(i,1) = cell2mat(NET.LW(i,i-1));
  wb(i,2) = cell2mat(NET.b(i));
end;