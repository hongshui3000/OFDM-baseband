% //ӳ��������ͼ
% //���������ݸ�ʽ: �ֳ�    16 bit
% //                ����λ  1 bit
% //                ����λ  1 bit
% //                С��λ  14 bit
clc
clear
close all
realstr = textread('QAM16_MAP_real_data.txt','%s');
imagstr = textread('QAM16_MAP_imag_data.txt','%s');
% fidr = fopen('QAM16_MAP_real_data.txt','r');
% fidi = fopen('QAM16_MAP_imag_data.txt','r');
% real = fscanf(fidr,'%16s',2);
% imag = fscanf(fidi,'%s');
% fclose(fidr);
% fclose(fidi);
realdec = bin2dec(realstr);
imagdec = bin2dec(imagstr);

realdec(find(realdec > 32768)) = realdec(find(realdec > 32768)) - 65536;
imagdec(find(imagdec > 32768)) = imagdec(find(imagdec > 32768)) - 65536;


real = realdec / (2^14);    %������תΪ������
imag = imagdec / (2^14);

qammapdata = complex(real,imag);
%scatterplot(qammapdata);
scatterPlot = commscope.ScatterPlot('SamplesPerSymbol',1,'Constellation',qammapdata);
scatterPlot.PlotSettings.Constellation = 'on';
scatterPlot.PlotSettings.ConstellationStyle = 'r*';

  
