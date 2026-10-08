module ACCUMULATOR(
    input wire clk, 
    input wire reset,
    input wire enable,
    input wire [5:0] data_in, //datele de intrare ce urmeaza a fi incarcate
    output reg [5:0] data_out //iesirea datelor curente salvate in registru
);
    //registru D pe 6 biti: se incarca pe frontul pozitiv cat timp enable e activ, 0x0 la reset
    always @(posedge clk or posedge reset) begin
        if (reset)
            data_out <= 6'b000000;
        else if (enable)
            data_out <= data_in;
    end
endmodule
