transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/hazardUnit.sv}

vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/hazardUnit_tb.sv}
vlog -sv -work work +incdir+D:/TEC/Primer\ Semestre\ 2023/Arqui/Proyecto\ 2/ybrenes_computer_architecture_1_2023/microarchitecture {D:/TEC/Primer Semestre 2023/Arqui/Proyecto 2/ybrenes_computer_architecture_1_2023/microarchitecture/hazardUnit.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  hazardUnit_tb

add wave *
view structure
view signals
run -all