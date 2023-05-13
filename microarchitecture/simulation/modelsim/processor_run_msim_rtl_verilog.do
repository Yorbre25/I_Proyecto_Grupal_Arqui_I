transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/buffer.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/instructionDecode.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/registerBank.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/signExtend.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/controlUnit.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/immSrcControl.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/branchFlagControl.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/aluControl.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/memWriteControl.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/memToRegControl.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/regWriteControl.sv}

vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/instructionDecode_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  instructionDecode_tb

add wave *
view structure
view signals
run -all
