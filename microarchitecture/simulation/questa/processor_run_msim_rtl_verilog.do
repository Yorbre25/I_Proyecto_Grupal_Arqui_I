transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture {C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture/SetFlags.sv}
vlog -sv -work work +incdir+C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture {C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture/Operator.sv}
vlog -sv -work work +incdir+C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture {C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture/Mux.sv}
vlog -sv -work work +incdir+C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture {C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture/ALU.sv}

vlog -sv -work work +incdir+C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture {C:/Users/yraul/Documents/Github/ybrenes_computer_architecture_1_2023/microarchitecture/UnitTestALU.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  UnitTestALU

add wave *
view structure
view signals
run -all