module SAP1_FPGA_TOP(
    input wire clk,        //100MHz, pin E3
    input wire CPU_RESETN, //butonul CPU RESET, activ pe 0
    output wire [7:0] AN,
    output wire [6:0] SEG, //{CA,CB,CC,CD,CE,CF,CG}
    output wire DP,
    output wire [15:0] LED //debug: LED[5:0] = ACC, LED[7] = HALT, LED[15:8] = PC
);
    wire reset = ~CPU_RESETN;

    wire clk_cpu, clk_seg;
    CLK_DIV divider(clk, reset, clk_cpu, clk_seg);

    //aceeasi legatura ca in modulul CPU, plus semnalul OUT_ACC scos pentru registrul de iesire
    wire [7:0] current_address;
    wire HALT;
    PC program_counter(clk_cpu, reset, ~HALT, current_address);

    wire [7:0] current_instr;
    MEMORY instruction_memory(current_address, current_instr);

    wire OP, LOAD_ACC, OUT_ACC;
    wire [5:0] A, B;
    DECODER instruction_decoder(current_instr, OP, LOAD_ACC, OUT_ACC, A, B, HALT);

    wire [5:0] ACC_IN, ACC_OUT, ALU_OUT;
    MUX2_1 acc_selector(LOAD_ACC, ALU_OUT, A, ACC_IN);
    ACCUMULATOR acc_reg(clk_cpu, reset, ~OUT_ACC, ACC_IN, ACC_OUT);
    ALU compute_unit(OP, ACC_OUT, B, ALU_OUT);

    //registrul de iesire: retine ACC doar la instructiunea OUT (nu si la HALT)
    wire [5:0] OUT_VALUE;
    OUT_REG out_register(clk_cpu, reset, OUT_ACC & ~HALT, ACC_OUT, OUT_VALUE);

    wire [3:0] tens, units;
    BIN2BCD converter(OUT_VALUE, tens, units);
    DISPLAY_7SEG display(clk_seg, reset, tens, units, AN, SEG, DP);

    assign LED = {current_address, HALT, 1'b0, ACC_OUT};
endmodule
