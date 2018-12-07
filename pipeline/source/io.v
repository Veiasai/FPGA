module io (addr, clock, data_in,  write_enable, io_in, io_out, io_data_out);
	input [4:0] addr;
	input   clock, write_enable;
	input [9:0]  io_in;
    input [31:0] data_in;

    output reg [31:0] io_data_out;
	output  reg [27:0]  io_out; 
    wire [13:0] io_temp_out;

    sevenseg  d1 (data_in[3:0], io_temp_out[6:0]);
    sevenseg  d2 (data_in[7:4], io_temp_out[13:7]);

    initial begin
        io_out = 0;
    end
    
    always @ (posedge clock) begin
        if (write_enable) begin
            case (addr)
            0: io_out[13:0] = io_temp_out;
            1: io_out[27:14] = io_temp_out;
            default: io_out = 0;
            endcase
        end

        case (addr)
            0: io_data_out = {28'b0, io_in[3:0]};
            1: io_data_out = {28'b0, io_in[7:4]};
            2: io_data_out = {28'b0, io_in[9:8]};
            default:
                io_data_out = 0;
		endcase
    end
endmodule