module io_sim(clock_50, reset, data_in, out1, out2, out3, out4);

	 input clock_50, reset;
     input [9:0]  data_in; // 0-4 5-9 switch
	 
	 output [6:0] out1, out2, out3, out4;

	 wire   [31:0]  pc_sim,inst_sim,aluout_sim,memout_sim;
     wire           imem_clk_sim,dmem_clk_sim;
	 wire mem_clk;

	 div2 			div_ins ( slow_clk, clock_50);
     sc_computer    sc_computer_instance (reset,  slow_clk, clock_50,
	 					pc_sim,inst_sim,aluout_sim,memout_sim, 
						 imem_clk_sim,dmem_clk_sim,
						 data_in,
						 {out4, out3, out2, out1});
endmodule



