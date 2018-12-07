module pipemem (we,addr,datain,clock, memclock,dataout, io_in, io_out);
    
    input  [31:0]  addr;
    input  [31:0]  datain;
    
    input          we, clock,memclock;
    output [31:0]  dataout;
    
    input [9:0] io_in;
    output [27:0] io_out;

    wire   [31:0]  ram_out, io_data_out;

    assign         dram_write_enable = we & ~clock & ~addr[7];
    assign         io_write_enable = we & ~clock & addr[7];
    assign         dataout = addr[7] ? io_data_out : ram_out; 
   
    lpm_ram_dq_dram  dram(addr[6:2], memclock, datain, dram_write_enable, ram_out);
    io				io_ins(addr[6:2], memclock, datain, io_write_enable, io_in, io_out, io_data_out);

endmodule 