module ALU(
    input wire OP, //operatia: adunare/scadere
    input wire [5:0] A, B, //operanzii
    output wire [5:0] S //rezultatul
);
    //OP = 0 -> adunare (ADD), OP = 1 -> scadere (SUB)
    //rezultatul e trunchiat la 6 biti (modulo 64), fara carry/overflow
    assign S = OP ? (A - B) : (A + B);
endmodule
