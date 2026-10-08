module MUX2_1(
    input wire SEL,
    input wire [5:0] A, //Datele din ALU
    input wire [5:0] B, //Datele din DECODER
    output wire [5:0] C
);
    //SEL = 1 (LOAD) -> data imediata din DECODER, altfel rezultatul din ALU
    assign C = SEL ? B : A;
endmodule
