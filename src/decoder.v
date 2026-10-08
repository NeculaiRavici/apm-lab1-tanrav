module DECODER(
    input  wire [7:0] instr, //instructiunea curenta
    output wire OP, //semnalul de operatie pt ALU incazul instructiunilor ADD/SUB
    output wire LOAD_ACC, //semnalul de selectie pentru MUX in cazul unei instructiuni LOAD
    output wire OUT_ACC, //semnalul marcare a unei instructiuni OUT ce va dezactiva accumulatorul
    output wire [5:0] A, //data incarcata in accumulator
    output wire [5:0] B, //data adunata/scazuta la/din acumulator
    output wire HALT //semnalul de oprire a procesorului ce dezactiveaza registrul PC
);
    wire [1:0] opcode = instr[7:6];
    wire [5:0] imm    = instr[5:0];

    wire is_load = (opcode == 2'b00);
    wire is_add  = (opcode == 2'b01);
    wire is_sub  = (opcode == 2'b10);
    wire is_sys  = (opcode == 2'b11); //OUT sau HALT

    assign OP       = is_sub;              //0 = adunare, 1 = scadere
    assign LOAD_ACC = is_load;             //MUX alege data imediata A in loc de iesirea ALU
    //OUT si HALT nu modifica acumulatorul, deci il dezactivam pentru ambele
    assign OUT_ACC  = is_sys;
    assign HALT     = is_sys && (imm == 6'b111111);

    //datele imediate apar doar pe iesirea instructiunii care le foloseste, altfel 0
    assign A = is_load ? imm : 6'b000000;
    assign B = (is_add || is_sub) ? imm : 6'b000000;
endmodule
