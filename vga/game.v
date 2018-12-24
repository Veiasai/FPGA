module game(clk, reset, b1, b2, b3, b4, r, g, b, h, v, bn, scores);

    input clk, reset, b1, b2, b3, b4;
    output reg [7:0] r, g, b;
    output reg [14:0] scores;
    output h, v, bn;
    
    wire clk2;
    wire[9:0] row, col;
    reg [9:0] tn;

    reg [9:0] t1, t2, t3, t4;
    reg [31:0] cnt;

    parameter integer cnt_c = 31'd500000000;

    div2 div(clk2, clk);
    vga_gen vga_gen(clk2, reset, row, col, h, v, bn);

    wire color;

    initial begin
    tn = 0;
    cnt = 0;
    t1 = 1;
    t2 = 0;
    t3 = 0;
    t4 = 0;
    scores = 0;
    r = 0;
    g = 0;
    b = 0;
    end

    always @ (negedge clk) begin
        tn = col / 160;
        cnt <= cnt + 1;
        if (cnt >= cnt_c) begin
            cnt <= 0;
            t1 <= t1 + (t1 != 0);
            t2 <= t2 + (t2 != 0);
            t3 <= t3 + (t3 != 0);
            t4 <= t4 + (t4 != 0);
        end
        r <= 0;
        case (tn)
            0: if(t1 != 0 && t1 <= row && t1 + 100 > row) r <= 100;
            1: if(t2 != 0 && t2 <= row && t2 + 100 > row) r <= 100;
            2: if(t3 != 0 && t3 <= row && t3 + 100 > row) r <= 100;
            3: if(t4 != 0 && t4 <= row && t4 + 100 > row) r <= 100;
            default:;
        endcase
    end
endmodule

