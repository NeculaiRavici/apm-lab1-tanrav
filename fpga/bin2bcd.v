module BIN2BCD(
    input wire [5:0] bin, //0..63
    output wire [3:0] tens,
    output wire [3:0] units
);
    //pe 6 biti valoarea maxima e 63, deci doua cifre zecimale ajung
    assign tens  = bin / 10;
    assign units = bin % 10;
endmodule
