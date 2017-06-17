# Created by Microsemi Libero Software 11.8.0.26
# Wed Jun 07 11:28:46 2017

# (OPEN DESIGN)

open_design "WOLF_CONTROLLER.adb"

# set default back-annotation base-name
set_defvar "BA_NAME" "WOLF_CONTROLLER_ba"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {C:\Users\rozen\Dropbox\EE_BSC_2017\G8\vhdl\CU_Droptest\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"


# import of input files
import_source  \
-format "edif" -edif_flavor "GENERIC" -netlist_naming "VHDL" {../../synthesis/WOLF_CONTROLLER.edn} \
-format "pdc"  {..\..\constraint\CU_Droptest.pdc} \
-format "sdc"  {..\..\constraint\CU_Main_32.sdc} -merge_physical "no" -merge_timing "yes"
compile
report -type "status" {WOLF_CONTROLLER_compile_report.txt}
report -type "pin" -listby "name" {WOLF_CONTROLLER_report_pin_byname.txt}
report -type "pin" -listby "number" {WOLF_CONTROLLER_report_pin_bynumber.txt}

save_design
