x_tr = 2*rand(1,10000)-1;
y_tr = sin(pi*x_tr);


PR = zeros(1,2);
PR(1,1) = min(x_tr);
PR(1,2) = max(x_tr);

SS = [2 3 1];

NET = newff (PR,SS,{"tansig" "tansig" "tansig"},"trainlm","learngdm","mse");

NET.trainParam.min_grad = 0; 
NET.trainParam.epochs= 150; 
NET = train(NET,x_tr,y_tr);
x_val = linspace(-1,1,100);
x_val = [x_val x_val x_val x_val x_val];
y_val = sim(NET, x_val);


plot(y_val,'.');

wb_gen(NET);
% system('mv wb_init.vhd ../src/wb_init.vhd')

fid = fopen('../data_in.txt','w');
fprintf(fid,'%f\n',x_val);
fclose(fid);
fid = fopen('../data_out_oct.txt','w');
fprintf(fid,'%f\n',y_val);
fclose(fid);
