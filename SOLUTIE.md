# Rezolvare Lucrarea 1 - SAP1

## Ce contine
- `src/alu.v`, `src/pc.v`, `src/decoder.v`, `src/accumulator.v`, `src/mux2_1.v` - cerintele 1-4
- `fpga/` - cerinta 5: divizor de ceas 1Hz, registru OUT, conversie BCD, afisaj 7 segmente, XDC pentru Nexys A7
- `fpga/sap1_fpga_tb.v` - testbench pentru top-ul FPGA, cu divizorul micsorat
- `create_project.tcl` - creeaza automat proiectul Vivado

## Pasi in Vivado
1. Deschizi Vivado (fara proiect) -> **Tools -> Run Tcl Script...** -> alegi `create_project.tcl` din acest folder.
2. **Simulare (cerintele 1-4):** Run Simulation -> Run Behavioral Simulation. In Scope selectezi `cpu_uut`,
   tragi `current_address`, `current_instr`, `B`, `HALT` in waveform, Restart, Run All, Radix -> Hexadecimal.
   Rezultat asteptat: `acc` = 00, 01, 03, 06, 02, 10, 0A, 0A, 00, 3F, 1F; HALT = 1 la adresa 0B.
3. **Placa (cerinta 5):** Generate Bitstream -> Open Hardware Manager -> Open Target -> Auto Connect -> Program Device.
   Afisajul arata 00, apoi 10 (dupa ~7s), apoi 31 (dupa ~11s); LED 7 = HALT. Butonul CPU RESET reporneste programul.

LED-uri de debug: LED[5:0] = ACC, LED[7] = HALT, LED[15:8] = PC.

## Observatie
In `code.mem`, linia comentata "SUB 32" e codificata `01_100000` (ADD 32). Rezultatul e acelasi:
63 + 32 = 95 = 31 (mod 64).
