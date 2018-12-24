module game(clk, clk_v, reset, b1, b2, b3, b4, r, g, b, h, v, bn, scores_out, switch);

    input clk, reset, b1, b2, b3, b4;
    input [3:0] switch;
    output clk_v;
    output reg [7:0] r, g, b;
    output reg [13:0] scores_out;
    reg [13:0] scores;
    output h, v, bn;
    
    wire clk_v;
    wire[9:0] row, col;
    reg [9:0] tn;

    reg [9:0] t1, t2, t3, t4;
    reg [31:0] cnt;
    reg [19:0] rand_num;
    reg [7:0] selector;

    reg [3:0] score1, score2;
    parameter integer cnt_c = 31'd2500000;

    div2 div(clk_v, clk);
    vga_gen vga_gen(clk_v, reset, row, col, h, v, bn);

    sevenseg s1(score1, scores_out[6:0]);
    sevenseg s2(score2, scores_out[13:7]);
    
    wire color;

    initial begin
    rand_num = 123456;
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
        tn <= col / 160;
        cnt <= cnt + 1;
        rand_num <= {rand_num[18:0], rand_num[19] ^ rand_num[0]};
        selector <= rand_num % 15;
        score2 <= scores / 10;
        score1 <= scores % 10;
        if (cnt >= cnt_c) begin
            t1 <= t1 + (t1 != 0) * switch * 2;
            t2 <= t2 + (t2 != 0) * switch;
            t3 <= t3 + (t3 != 0) * switch * 2;
            t4 <= t4 + (t4 != 0) * switch;
            case (selector)
            0: if (t1 == 0) t1 <= 1;
            2: if (t2 == 0) t2 <= 1;
            4: if (t3 == 0) t3 <= 1;
            6: if (t4 == 0) t4 <= 1;
            default: ;
            endcase
            cnt <= 0;
            if (t1 >= 350 && ~b1) begin t1 <= 0; scores = scores + 1; end
            if (t2 >= 350 && ~b2) begin t2 <= 0; scores = scores + 1; end
            if (t3 >= 350 && ~b3) begin t3 <= 0; scores = scores + 1; end
            if (t4 >= 350 && ~b4) begin t4 <= 0; scores = scores + 1; end

            if (t1 >= 500) t1 <= 0;
            if (t2 >= 500) t2 <= 0;
            if (t3 >= 500) t3 <= 0;
            if (t4 >= 500) t4 <= 0;
        end
        r <= 0; g <= 0; b <= 0;

        if (col % 160 <= 20 || col % 160 >= 140)
            b <= 100;
        else if (row >= 420 && row <= 430)
            g <= 100;
        else begin
            case (tn)
                0: if(t1 != 0 && t1 <= row && t1 + 70 > row) r <= 100;
                1: if(t2 != 0 && t2 <= row && t2 + 70 > row) r <= 100;
                2: if(t3 != 0 && t3 <= row && t3 + 70 > row) r <= 100;
                3: if(t4 != 0 && t4 <= row && t4 + 70 > row) r <= 100;
                default:;
            endcase
        end


    end
endmodule

