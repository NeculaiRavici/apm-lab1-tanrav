# Creeaza proiectul Vivado complet pentru SAP1.
# In Vivado: Tools -> Run Tcl Script... -> alegi acest fisier.
set origin [file dirname [file normalize [info script]]]

create_project sap1 $origin/vivado_project -part xc7a100tcsg324-1 -force

# surse de design (cerintele 1-4 + memoria si programul)
add_files -fileset sources_1 [list \
    $origin/src/alu.v \
    $origin/src/pc.v \
    $origin/src/decoder.v \
    $origin/src/accumulator.v \
    $origin/src/mux2_1.v \
    $origin/src/memory.v \
    $origin/src/cpu.v \
    $origin/src/code.mem \
    $origin/fpga/clk_div.v \
    $origin/fpga/out_reg.v \
    $origin/fpga/bin2bcd.v \
    $origin/fpga/display_7seg.v \
    $origin/fpga/sap1_fpga_top.v ]

# testbench-uri
add_files -fileset sim_1 [list \
    $origin/src/cpu_tb.v \
    $origin/fpga/sap1_fpga_tb.v ]

# pinii placii Nexys A7
add_files -fileset constrs_1 $origin/fpga/nexys_a7.xdc

set_property top SAP1_FPGA_TOP [get_filesets sources_1]
set_property top cpu_testbench [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1

puts "Proiect SAP1 creat in $origin/vivado_project"
