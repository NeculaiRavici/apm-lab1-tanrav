module sap1_fpga_tb();
    reg clk = 1'b0, CPU_RESETN = 1'b0;
    wire [7:0] AN;
    wire [6:0] SEG;
    wire DP;
    wire [15:0] LED;

    //divizor mic ca simularea sa nu dureze 100 de milioane de cicli
    SAP1_FPGA_TOP #() uut(clk, CPU_RESETN, AN, SEG, DP, LED);
    defparam uut.divider.HALF_PERIOD = 8;
    defparam uut.divider.SEG_BIT = 1;

    always #5 clk = ~clk;

    initial begin
        #20 CPU_RESETN = 1'b1;
        #3000 $finish();
    end
endmodule
