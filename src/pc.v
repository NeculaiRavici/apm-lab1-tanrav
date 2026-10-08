module PC(
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [7:0] pointer //adresa instructiunii curente
);
    //la reset pornim de la adresa 0x0, apoi incrementam la fiecare front pozitiv cat timp enable e activ
    always @(posedge clk or posedge reset) begin
        if (reset)
            pointer <= 8'h00;
        else if (enable)
            pointer <= pointer + 8'd1;
    end
endmodule
