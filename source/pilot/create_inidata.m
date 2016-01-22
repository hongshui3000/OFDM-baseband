%%%%���ݸ�ʽ���з��ŵĶ�������λ��16bit
%%%%˫��RAM��ַ��Χ0-127�����16bit
clc;
clear;
close all;
P = fi(1,1,16,14);   %%����Ƶ����1תΪ�з��Ŷ�����
N = fi(-1,1,16,14);  %%����Ƶ����-1תΪ�з��Ŷ�����
Pilot_P = P.hex;
Pilot_P = hex2dec(Pilot_P);
Pilot_N = N.hex;
Pilot_N = hex2dec(Pilot_N);
width = 16;
depth = 128;

initial_data = zeros(1,depth);

initial_data(1,7+1) = Pilot_P;  %%��Ƶ����λ��7��21��43��57
initial_data(1,21+1) = Pilot_N;
initial_data(1,43+1) = Pilot_P;
initial_data(1,57+1) = Pilot_P;
initial_data(1,7+64+1) = Pilot_P;
initial_data(1,21+64+1) = Pilot_N;
initial_data(1,43+64+1) = Pilot_P;
initial_data(1,57+64+1) = Pilot_P;

addr = [0:depth - 1];
file = fopen('pilot_data.mif','wt');
fprintf(file,'WIDTH=%d;\n',width);       %�ø�ʽ��Ӧ��mif��ʽ�����Ҫ��
fprintf(file,'DEPTH=%d;\n',depth);
fprintf(file,'\n');
fprintf(file,'ADDRESS_RADIX=UNS;\n');
fprintf(file,'DATA_RADIX=HEX;\n');
fprintf(file,'\n');
fprintf(file,'CONTENT BEGIN\n');
for i=1:depth
    fprintf(file,'    %d  :  %X;\n',addr(i),initial_data(i));
end
fprintf(file,'\n');
fprintf(file,'END;\n');
fclose(file);