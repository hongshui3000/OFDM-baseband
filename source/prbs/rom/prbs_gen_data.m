%%%% the file genertor prbs data for the ROM content data
function prbs_gen_data
depth = 2^15;
width = 1;
prbs_out = PRBS(15,15,14);  %%����������2^15-1
prbs = [prbs_out 0];
addr = [0:depth-1] ;
file = fopen('prbs_data.mif','wt');
fprintf(file,'WIDTH=%d;\n',width);       %�ø�ʽ��Ӧ��mif��ʽ�����Ҫ��
fprintf(file,'DEPTH=%d;\n',depth);
fprintf(file,'\n');
fprintf(file,'ADDRESS_RADIX=UNS;\n');
fprintf(file,'DATA_RADIX=BIN;\n');
fprintf(file,'\n');
fprintf(file,'CONTENT BEGIN\n');
for i=1:depth
    fprintf(file,'    %d  :  %X;\n',addr(i), prbs(i));
end
fprintf(file,'\n');
fprintf(file,'END;\n');
fclose(file);













%PRBS���з�����
function prbs_out = PRBS(shifitreg_len,pol_a,pol_b)
%���ɳ���PRBS 7,PRBS 15,,PRBS 23,PRBS 31,
%��Ӧ����ʽX^7+X^6+1, X^15+X^14+1, X^23+X^18+1, X^31+X^28+1,

	period = 2^shifitreg_len-1;
	reg=ones(1,shifitreg_len);   
	prbs_out=zeros(1,period);
	for i=1:period
		prbs_out(i)=reg(pol_a);
		temp=reg(pol_b);
		for j=shifitreg_len:-1:2
			reg(j)=reg(j-1);
		end
		reg(1)=xor(prbs_out(i),temp);
	end