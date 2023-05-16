transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/mainMemory.v}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/processor.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/flagRegister.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/SetFlags.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/Operator.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/Mux.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/ALU.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/buffer.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/instructionDecode.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/mux21.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/registerBank.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/signExtend.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/controlUnit.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/immSrcControl.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/branchFlagControl.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/operatorsAluMux.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/aluControl.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/memWriteControl.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/memToRegControl.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/mux41.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/instructionFetch.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/adder.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/pcUpdate.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/regWriteControl.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/writeBack.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/exec.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/hazardUnit.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/resetModule.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/branchTaken.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/IOMemory.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/chipSet.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/dataMemory.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/memoryStage.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/ALUMux.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/instructionMemory.sv}

vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/processor_tb.sv}
vlog -sv -work work +incdir+D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture {D:/Git/ybrenes_computer_architecture_1_2023/microarchitecture/processor.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all
