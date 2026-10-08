module DISPLAY_7SEG(
    input wire clk_seg, //ceasul de baleiere
    input wire reset,   //activ pe 1
    input wire [3:0] tens,
    input wire [3:0] units,
    output reg [7:0] An,  //anozii, activi pe 0
    output reg [6:0] Seg, //{a,b,c,d,e,f,g}, activi pe 0
    output wire DP
);
    reg digit; //0 = unitati (AN0), 1 = zeci (AN1)
    reg [3:0] BCD;

    always @(posedge clk_seg or posedge reset) begin
        if (reset)
            digit <= 1'b0;
        else
            digit <= ~digit;
    end

    always @(*) begin
        if (digit == 1'b0) begin
            BCD = units;
            An  = 8'b1111_1110;
        end else begin
            BCD = tens;
            An  = 8'b1111_1101;
        end

        case (BCD)
            4'd0: Seg = 7'b0000001;
            4'd1: Seg = 7'b1001111;
            4'd2: Seg = 7'b0010010;
            4'd3: Seg = 7'b0000110;
            4'd4: Seg = 7'b1001100;
            4'd5: Seg = 7'b0100100;
            4'd6: Seg = 7'b0100000;
            4'd7: Seg = 7'b0001111;
            4'd8: Seg = 7'b0000000;
            4'd9: Seg = 7'b0000100;
            default: Seg = 7'b1111111; //stins
        endcase
    end

    assign DP = 1'b1; //punctul zecimal stins
endmodule
