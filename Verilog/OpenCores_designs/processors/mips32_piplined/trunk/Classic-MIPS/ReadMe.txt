SimpleMIPS˵����
	1��ʵ�ֵ����ڵ�MIPSָ�
	2: ���ʱ��Ƶ�ʿɴ� 5.4ns <=> 185MHz


PipelineMIPS˵����
	1: ʵ��IF, ID, EX, MEM, WB���弶��ˮ�ṹ
	2:δʹ����·������ǰ:
		1)����ð�գ�Ҫ��ȴ�3��nopָ�
			ori $t0, $zero, 10
			nop
			nop
			nop
			add $s0, $s0, $t0
		ori��add֮����Ҫ�ȴ�3��nopָ�������$t0���������ܡ�
	
		2)������Page206��ʽ�޸�IF��(decode.v)
			a:ʹʱ�����ڵ�ǰ���ִ��д����������ִ�ж�������ʹ�ö�������ȡ�����µ����ݡ�
			b:����ʵ����������:
				I: ���ַ���ȷʵ������������ð�յȴ�ʱ�䣬��3��nopָ�����Ϊ2��nopָ�
				II: ��������Ӱ����ʱ�򣡣������ַ���ʹ�üĴ������reg1_data��reg2_dataֻ��ά�ְ��ʱ�����ڣ�
					�����˺�������ALU�����ʱ�䡣
				III: ���ǵ�ʱ��Ĵ��ۣ� ����Ʒ���������Ż�������
	3: ���ʱ��Ƶ�ʿɴ�: 3.4ns <=> 294MHz
		
		
PipelineMIPS_opt˵����
	1����PipelineMips�м�����·���������ơ�
	2: ��WB��������·���ƣ�ʹ�ö��������Զ�ȡ�����µ����ݣ� ��������һ��.2.2)��ͬ�����Լ���һ��nopָ��ĵȴ�ʱ�䣬 ���Ƕ�ʱ��û��Ӱ�졣
		�����޸���decode.v�У���reg1_data��reg2_dataʹ��һ��ѡ����MUX������·�������������д����ͬʱ����ʱ���Զ���������
		��·��ʹ�ö�������ȡ���µ����ݡ�
		    /* create a bypath for reg1 output */
            if(regwrite_flag && write_reg == rs)
                reg1_data <= write_data;
            else
                reg1_data <= registers[rs];
            /* create a bypath for reg2 output */
            if( regwrite_flag && write_reg == rt)
                reg2_data <= write_data;
            else
                reg2_data <= registers[rt];
	3:������Page.211����������·���ƣ� ������ѡ������·��Ԫ��
		��·��Ԫ����Ʋ���Page.210������MEMð�յĿ��Ʋ���ʹ������ģ�����������ģ� ��û�мӺ���ġ�
		assign forwardA_ex_mem_condition = (ex_mem_regwrite_flag == 1'b1) && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rs);
		assign forwardA_mem_wb_condition = (mem_wb_regwrite_flag == 1'b1) && (mem_wb_rd != 0) && ( mem_wb_rd == id_ex_rs);
    
		assign forwardB_ex_mem_condition = (ex_mem_regwrite_flag == 1'b1) && (ex_mem_rd != 0) && (ex_mem_rd == id_ex_rt);
		assign forwardB_mem_wb_condition = (mem_wb_regwrite_flag == 1'b1) && (mem_wb_rd != 0) && ( mem_wb_rd == id_ex_rt);
	4��������Page.214���������������ơ�
		lw $t0, 0($zero)
		addi $s0, $t0, $t1
		����addi��Ҫ����lw��$t0�Ĵ�������ʹ��������·���ƣ�lw֮����Ȼ��������һ��ʱ�����ڣ�����addi�޷����ʵ�$s0����ȷֵ��
	5: 1)��ʹ��Block_Ram��Ϊ���ݴ洢��ʱ�� ���ڶ�������һ��ʱ�����ڵ���ʱ����˶������Ľ��û��ʹ�üĴ������塣�ڼ�����·���ƺ�Block_Ram�������ALU�������ǹؼ�·����
		����Ӱ����ʱ��
	   2)���ʹ��Distributed Ram��Ϊ���ݴ洢���� ��������û����ʱ�ģ� ��ô�������Ľ�����Ի��浽��ˮ�߼Ĵ����У�ʱ���ܹ��õ����⡣
	   3)��Ram.v��ͬʱ������Block_Ram��Distributed Ram���û���ͨ������� __BLOCK_RAM__ ��ѡ��Ram�����ࡣ
	6: 1)�ڲ��Ż�����ð�յ�������:
			beq, bne, j�ȷ�֧����תָ����棬 ��Ҫ�ȴ�3��nopָ�
	   2)ʵ������Page.215��"�����֧������"�Ŀ���ð�ս�����ԡ�
			�����֧���ᷢ�������MEM������֧������������ �����ִ�У�
								���MEM������֧���������� �����(FLUSH)��ָ֧��������ָ�������������:
								1)IF����reg_instruction���ó�NOP
								2)ID���Ŀ����ź�ȫ�������0��
								3)EX���Ŀ����ź�ȫ�������0.
	7:���ʱ��Ƶ�ʣ�5.4ns <=> 185MHz
	
PipelineMIPS_opt2˵����
	1)��Ram.vģ�飬RAM�������ַ������2λ��
		��ΪMIPS�У� Ҫ��RAM�ĵ�ַ���Ǳ�4������������Ƶ�RAM�����ݿ�ȶ���32-bit�ģ� ��˿��Խ���ַ����2λ�� �൱��������2λ��
		��Ҫ���û�д���ʱ�� ���뱣֤��ַ����4��������������
		assign addr = ALU_out[9:2];
	2)a:���ۺϺ�ʱ�������֪�� PipelineMIPS_opt���������PipelineMIPS����ʱ��񻯵�ԭ���ǣ�
			EX��������·���ƺ�������EX���Ĺؼ�·�����ؼ�·������:
				mem/reg_write_reg ->EX����·��Ԫ(bypath_ctr) -> EX��·ѡ����(bypass) ->ALU/ALU_out -> ALU/zero_flag
	  b:�Ż�����1��
		Ϊ�����������ؼ�·���� ����·��Ԫbypath_ctr�Ƶ�ID��ִ�С�
		��ID����ǰִ����·��Ԫ����Ϊ��·��Ԫ��������ݶ�������ǰ�õ���Ȼ�󽫼��㵽��forward_a, forward_b�Ĵ������棬 Ȼ���䵽EX����
			�Ż���Ĺؼ�·������:
			mem/ram_out -> EX��·ѡ����(bypass) -> ->ALU/ALU_out -> ALU/zero_flag
		�Ż��������ؼ�·����ʱ��5.4ns���ٵ���4.4ns.
	  c)�Ż�����2:
		Ϊ�˽�һ�����̹ؼ�·������zero_flag�ļ����EX����ALUת�Ƶ�MEM�����㡣
		��ΪALU��Ԫ�ȼ����ALU_out, Ȼ�����ALU_out�����zero_flag�� ���zero_flag����ʱ��ALU_out������
		����ALU_out��ͨ����ˮ�߼Ĵ�������MEM������˿�����MEM������zero_flag���Ӷ�����EX���Ĺؼ�·����
			�Ż���Ĺؼ�·������:
			mem/ram_out ->EX��·ѡ����(bypass) ->ALU/ALU_out
		�Ż��������ؼ�·����ʱ��4.4ns���ٵ���3.8ns.
	3)�����PipelineMIPS���̣� PipelineMIPS_opt2��������·���������֧Ԥ����ƣ����������ð�պͿ���ð�����⣬�����ǹؼ�·���ӳ���0.4ns(3.4ns->3.8ns).
		�����SimpleMIPS���̣�ʹ����ˮ�ߣ� ʱ��Ƶ�ʴ�185MHz��ߵ�263MHz.
	
	4)���ʱ��Ƶ��: 3.8ns <=> 263MHz
	
PipelineMIPS_opt3˵��:
	1:��IF�׶Σ�����Flush��Hazard��ϵ��
		Flush�����ȼ�����Hazard.
	2: �Ż�JUMPָ�
		��IF�׶���ǰ���룬�жϵ�ǰָ���Ƿ���JUMPָ�
		�����ǰָ����JUMPָ� �жϺ�����ˮ�����Ƿ���branchָ������branchָ�����ֱ��branchָ�����.(��Ϊ���Jumpǰ����branchָ� ��ôJump��һ����ִ��)
					���������ˮ����û��branchָ� IF������JUMP���µ�ַ�� ������Ҫ�ȵ�MEM����
	3:ͨ�������ʱ��ķ�������ʱ����ʱ��3.8ns���ٵ�3.1ns��
		����Ķ����£�
		1) ALU.v�������c_addsub_0ģ��ʵ��add/sub���ܣ�������ALU������ʱ��
			!!����DSPʵ�ֱ�LUTʵ�����ܶ࣡��������c_addsub_0����16��LUTʵ�ֵġ�
		2)�����bypath2.vģ�飬 ��ALUSrc_flag��������·ѡ������bypath2�� ����ALU.v������һ��ѡ��������ʱ��
			���Ǵ����������˽϶��LUTʵ��bypath2ģ�顣
		3)mem/isFlush�ź������ǹؼ��ź�·������Ϊzero_flag������ʹ��isFlush�ź���ʱ�ܳ������ʹ����ALU_out�Ƚ���������
			zero_flag�������㣬������isFlush��ʱ�� ������ʹ�ý϶��LUTʵ��zero_flag�ıȽ�����
			//    assign isFlush =  ((ctr_m[3:2] == `BRANCH_OP_BEQ) && (zero_flag == 1'b1)) || 
			//                ( (ctr_m[3:2] == `BRANCH_OP_BNE) && (zero_flag == 1'b0) );
				assign isFlush =  ((ctr_m[3:2] == `BRANCH_OP_BEQ) && (ALU_out == 32'h0)) || 
						( (ctr_m[3:2] == `BRANCH_OP_BNE) && (ALU_out != 32'h0) );
		4)execute/ALU_ctr�У� instruction->ALUcmd->ALU_out�ǹؼ�·������ˣ���ALU_ctrģ���executeǨ�Ƶ�decode�����㡣
	4:���������Ż������ʱ��Ƶ��: 3.1ns <=> 322MHz
	
PipelineMIPS_opt4˵��:
	1:Ϊ��ʵ��jal jr����תָ� ��MIPS�Ĵ����е�$ra(��31�żĴ���)Ų��fetch�У� ��Ϊֻ��fetch����ʹ�õ�$ra.
		jal��jr��ʹ�ã���ʵ�ֺ������õĹ��ܡ�������ú����ĵ�ַ�����غ����ִ�С�
		###jal���ú���, jr�������ء�
		�������Ӽ� /TestBenchs/function/code.smd
		
		���������ǲ�֧�ֺ�����Ƕ�׵��ã�����(�����������õ��Ӻ����������������� ����$ra�����ǵ��¹��ܴ���)
		
	2: jalָ����jָ�������ͬ�� ֻ�Ƕ���ִ�� $ra = [PC] + 4�� ���ݴ���һ��ָ��ĵ�ַ�����ʹ��jal���ú�����
	3: jrָ�������޸ģ���Ӳ���Ͻ����������� ʹ��ֻ֧�� jr $ra, ��ֻ����ת��$raָ���λ��.���ʹ��jrʵ�ֺ������ء�
	4:���������Ż������ʱ��Ƶ��: 3.1ns <=> 322MHz
	5����Դʹ������� ����xc7z045ffg900-2оƬ��
		FF: 1463
		LUT: 1744
		
PipelineMIPS_opt4_example˵��:
	1: ����PipelineMIPS_opt4����¼��ˮ��/TestBenchs/led/code.smd���򣬴������̡�����λ�����ϰ��Ӳ��ԡ����Թ���������


PipelineMIPS_opt5_cache
	1: ��PipelineMIPS_opt4�����ϼ���һ��ֱ��ӳ���cache
	2: cache˵��
		1)cache: ���С��8����(8x32)��64��ʴ�С:64x8x32= 16K bit = 2K byte
		2)cache����ʱ����д���ǵ���������ɡ�
		3)cache����дȱʧ����д�ز��ԡ�
	3������cache��ʱ����΢�����ʱ��Ƶ��: 3.4ns <=> 294MHz
	
PipelineMIPS_opt5_cache_example3
	1: ����PipelineMIPS_opt5_cache�� ��¼��������/TestBenchs/cache_example/code.smd���򣬴������̡�����λ�����ϰ��Ӳ��ԡ����Թ���������
	2�����������¹��ܣ� ��������
		1)ʹ��BRAM_Controller IPʵ�ֶ�����ķ���. (������True Dual Port�� һ��Port��cache�� һ��Port���û�ʹ��)
		2)������MIPS���ó�������DIV��
		3)������cache�Ķ�д��ȱʧ���ط����д�صȹ��ܡ�
	3���洢����������������:
		1)ͨ���û�Port(BRAM_Controller)������д������Ĳ�������addr = 0, 4
		2)MIPS��������,��ʱ������ȱʧ��������������ݵ�cache�С�
		3)MIPS���г������㣬���������浽cache�ĵ�ַaddr = 32, 36
		
		/* һ��Ϊ����MIPS��cacheÿ�μ��ص��û�д�뵽��������²������� ��ôӦ����addr = 0, 4��cacheʧЧ���Ա��´�
		���������·��� */
		4) "lw $t0, 2048($zero)", ��ָ���� addr = 0,4��cacheʧЧ
		
		/* ����Ϊ�����û���ȡ���������� ��Ҫ��addr = 32, 36��Ӧ��cacheд�ص������� */
		5) "lw $t1, 2080($zero)", ��ָ���� addr = 32, 36��Ӧ��cacheд�ص������У�Ȼ���û�ͨ��BRAM_Controller����
		��ȡ��������
	4������cache��ϵͳ�У����û�ͨ��BRAM_Controller��������ʱ����Ҫע��cache�������һ�������⡣	

	
PipelineMIPS_opt6_cache_bht
	1: ��fetch����������һ��1024���BHT(branch history table)���ö�̬��֧Ԥ����߷�֧��׼ȷ�ʡ�
	2��BHT����1024� ʹ�÷�ָ֧���ַ�ĵ�λ����������ÿ���С��33-bit:
		1):bit:32, Ԥ��λ��Ԥ��÷�ָ֧���Ƿ�����
			�����λΪ1����ʾԤ���֧��������bit[31:0]��Ϊ��һ��ָ���ַ��
			�����λΪ0����ʾԤ���֧�������� ��һ��ָ���ַΪ��ǰָ���ַ + 4.
		2): bit[31:0] ��ָ֧���ʱ��Ӧ����תĿ���ַ��
	3������
		1)û��ʹ��bhtǰ������Ԥ�ⲻ�����Ĳ��ԣ�Ԥ��׼ȷ�ʴ�Լ50%
		  ʹ��bht�󣬸��ݾֲ���ԭ�� Ԥ��׼ȷ�ʿ� >50%.
		2)���Է���, bhtȷʵ������Ч���Ԥ��׼ȷ�ʣ�����������ٶȡ�
		
	4: ����cache��bht���ۺϱ�������:
		1) ����bht�� ��߹���Ƶ��: 3.5ns => 285.7MHz
			�ؼ�·����Ȼ��cache, ��reg_ALU_out -> isCacheDone.
		2) ��Դʹ��
			FF:  			1626
			LUT: 			3004
			MEMORY LUT:		983
			BRAM:			7.5
			
PipelineMIPS_opt7_cache_bht
	1: ��bht��Ԥ��λ����1-bit��չ��2-bit,�����׼ȷ��.
	4: ����cache��bht���ۺϱ�������:
		1) ����bht�� ��߹���Ƶ��: 3.6ns => 277.8MHz
			�ؼ�·����Ȼ��cache, ��reg_ALU_out -> isCacheStall.
		2) ��Դʹ��
			FF:  			1630
			LUT: 			3163
			MEMORY LUT:		1015
			BRAM:			7.5

PipelineMIPS_opt8_cache_bht
	1: ��PipelineMIPS_opt7_cache_bht�����ϣ� ��SimpleCache������΢�޸ġ�
		ȥ����cache_done�źţ� ֱ�����isCacheStall�źţ� ʹ�ӿڼ��һЩ��
	2����Դ��ʱ�򼸺���ͬ��
	
PipelineMIPS_opt9_cache_bht
	1��Ŀ��������j, jal, jr������תָ���ʵ�ֶ�$ra�Ĵ����Ķ�д������ʵ�ֺ�����Ƕ�׵��á�
		Ŀǰj, jal, jrָ�������ơ� jrָ���֧���κμĴ����� ������$ra��
		
		���⻹�޸���lwָ����decode��һ��bug�� ��isHazard�ǣ� Ӧ����reg_pc <= reg_pc������ᵼ����ת��תָ��
		��ַ����
		
	2���޸�
		1)��$ra��fetch��Ų�ص�decode���� ��������registers�Ĵ������У�ʹ��$ra�ܹ��������ʡ�
		2) jalָ���ִ�н�Ϊ���⣬ ��Ҫ����regwrite_flag�źš���������$rt���������reg_ALU_out��ֵ��
			��ʵ�� $ra <-- [PC] + 4.
		3)��jal. j, jr��ָ��������������ָ֧���ʹ��BHT���з�֧��̬Ԥ�⡣
			�����branchָ� ��תָ��ķ�֧һ���ᷢ������˿��������������֧����������fetch������BHT
			���з�֧��̬Ԥ�⣬ ��mem����BHT����������
	3���޸ĺ���Դ��������:
		FF: 			1709
		LUT: 			3171
		MEMORY LUT:		1015
		BRAM:			7.5
	4:�޸ĺ�ʱ��õ����Ż�����߹���Ƶ��: 3.5ns => 285.7.1MHz��
	5: �����ڴ�������Գ����з��֣����ĵ��������������٣���������������
	
