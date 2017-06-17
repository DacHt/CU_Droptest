quietly set ACTELLIBNAME ProASIC3
quietly set PROJECT_DIR "C:/Users/rozen/Dropbox/EE_BSC_2017/G8/vhdl/CU_Droptest"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap proasic3 "C:/Microsemi/Libero_SoC_v11.8/Designer/lib/modelsim/precompiled/vhdl/proasic3"

vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/CUTTER_PWM.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/System_clock.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/WOLF_CONTROLLER.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/CU_Main/CU_Main.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/CU_MAIN_TBT/CU_MAIN_TBT.vhd"

vsim -L proasic3 -L presynth  -t 1ps presynth.CU_MAIN_TBT
add wave /CU_MAIN_TBT/*
run 1000ns
