module CLK_DIV #(
    parameter HALF_PERIOD = 50_000_000, //100MHz / (2 * 50_000_000) = 1Hz exact
    parameter SEG_BIT     = 17          //100MHz / 2^18 ~ 381Hz pentru baleierea afisajului
)(
    input wire clk_in, //ceasul placii, 100MHz
    input wire reset,  //activ pe 1
    output reg clk_cpu, //1Hz pentru procesor
    output wire clk_seg //ceasul de baleiere al afisajului
);
    reg [31:0] counter_cpu;
    reg [SEG_BIT:0] counter_seg;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter_cpu <= 0;
            counter_seg <= 0;
            clk_cpu <= 1'b0;
        end else begin
            counter_seg <= counter_seg + 1;
            if (counter_cpu == HALF_PERIOD - 1) begin
                counter_cpu <= 0;
                clk_cpu <= ~clk_cpu;
            end else
                counter_cpu <= counter_cpu + 1;
        end
    end

    assign clk_seg = counter_seg[SEG_BIT];
endmodule
