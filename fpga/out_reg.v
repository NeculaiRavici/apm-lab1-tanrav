module OUT_REG(
    input wire clk,
    input wire reset,
    input wire enable, //OUT_ACC: se incarca doar la o instructiune OUT
    input wire [5:0] data_in,
    output reg [5:0] data_out
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            data_out <= 6'b000000;
        else if (enable)
            data_out <= data_in;
    end
endmodule
