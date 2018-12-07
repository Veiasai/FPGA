module sc_datamem (addr,datain,dataout,we,clock,mem_clk,dmem_clk, io_in, io_out);
 
   input  [31:0]  addr;
   input  [31:0]  datain;
   
   input          we, clock,mem_clk;
   output [31:0]  dataout;
   output         dmem_clk;
   
   input [9:0] io_in;
   output [27:0] io_out;

    wire   [31:0]  ram_out, io_data_out;

   wire           dmem_clk;    
   wire           write_enable; 
   assign         dram_write_enable = we & ~clock & ~addr[7];
   assign         io_write_enable = we & ~clock & addr[7];
   assign         dataout = addr[7] ? io_data_out : ram_out; 
   assign         dmem_clk = mem_clk & ( ~ clock);
   
   lpm_ram_dq_dram  dram(addr[6:2], dmem_clk, datain, write_enable, ram_out);
   io				io_ins(addr[6:2], dmem_clk, datain, io_write_enable, io_in, io_out, io_data_out);

endmodule 