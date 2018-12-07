module pipeif (pcsource,pc,bpc,rpc,jpc,npc,pc4,ins, mem_clk);
    input [31:0] pc,bpc,rpc,jpc;
    input [1:0]  pcsource;
    input       mem_clk;
    output [31:0] npc,pc4,ins;
    mux4x32 next_pc (pc4,bpc,rpc,jpc,pcsource,npc);
    cla32 pc_plus4 (pc, 32'h4, 1'b0, pc4);
    
    //pipeimem inst_mem (pc, ins);
    
    lpm_rom_irom irom (pc[7:2],mem_clk,ins); 
   
endmodule