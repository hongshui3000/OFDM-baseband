%function ofdm_sim
	clc;clear all;close all;
	rx_data=PRBS(15,15,14);
	map_dout = map(rx_data,2);
	pilot_dout = insert_pilot(map_dout);
    her_data = hermitian_conj(pilot_dout);  %%�Ƿ���й���ԳƱ任
	[iffta,ifftb] = size( her_data);
	
	ifft_dout = zeros(iffta,ifftb);
	for i = 1:iffta
		ifft_dout(i,:) = ifft( her_data(i,:));
    end
    
    cp_dout = add_cp(ifft_dout);
    
	%save data rx_data map_dout pilot_dout her_data ifft_dout cp_dout
	
	ccp_dout = cp_dout';          %�����������ܶ�
    ccp_dout = reshape(cp_dout',1,iffta*80);
    f=fftshift(fft(ccp_dout));
    p=10*log10(abs(f));
    x=-20:40/length(ccp_dout):20;
	plot(x(1:length(ccp_dout)),p)
    xlabel('Ƶ�� (MHz)'); ylabel('���� (dB)');
   
%%%%%%�����뵼Ƶ������ݽ���ifft�任(�Ƚ�ʮ�����Ʊ�ʾ�Ķ�����ת��Ϊ������)
%%	realdec = real(pilot_dout);
%%	imagdec = imag(pilot_dout);
%%	realdec(find(realdec > 32768)) = realdec(find(realdec > 32768)) - 65536;
%%	imagdec(find(imagdec > 32768)) = imagdec(find(imagdec > 32768)) - 65536;
%%
%%	realaa = realdec / (2^14);    %������תΪ������
%%	imagaa = imagdec / (2^14);
%%
%%	ifftdata = complex(realaa,imagaa);
%%	ifft_dout_a = zeros(iffa,iffb);
%%	for i = 1:iffa
%%		ifft_dout_a(i,:) = ifft(ifftdata(i,:), 64);
%%	end
%%	save ifft_dout_a;
%%	
%%	%%%%�������ݵ�����ͼ
%%	map_realdec = real(map_dout);
%%	map_imagdec = imag(map_dout);
%%	map_realdec(find(map_realdec > 32768)) = map_realdec(find(map_realdec > 32768)) - 65536;
%%	map_imagdec(find(map_imagdec > 32768)) = map_imagdec(find(map_imagdec > 32768)) - 65536;
%%
%%	map_realaa = map_realdec / (2^14);    %������תΪ������
%%	map_imagaa = map_imagdec / (2^14);
%%
%%	qammapdata = complex(map_realaa,map_imagaa);
%%  scatterplot(map_dout);
	%scatterPlot = commscope.ScatterPlot('SamplesPerSymbol',1,'Constellation',map_dout);
	%scatterPlot.PlotSettings.Constellation = 'on';
	%scatterPlot.PlotSettings.ConstellationStyle = 'r*';
