
ifvc -label VC_SKIP_PDP1
iomgrinstall -entry pdpFBC -name /pdpfbc

creat -name /pdpfbc/PBUS_PCI: -pmode 0 -errlabel ERROR_PBUS

task -slotname pbus -entp read_ts -pri 72 -vwopt 0x1c -stcks 10000 -nosync -auto
readparam -devicename /PBUS_PCI:/bus_read -rmode 1 -buffersize 100

# Add Profibus to system dump service
sysdmp_add -name FIELDBUS_PBFBC -show pdpfbc_sysdmp

goto -label VC_SKIP_PDP2

#VC_SKIP_PDP1

creat -name /simfbc/PBUS_PCI: -pmode 0

#VC_SKIP_PDP2
#ERROR_PBUS

###################################################################################

# Add IncTemplate to system dump service
sysdmp_add -name PNET -show PnetSysDump

echo -text "Starting Profinet and installs the driver/networks"

# INC DRIVER INSTALLATION:

# Debug from installation
# 768 = Hex 300
# 7425 = Hex 1D01
# 7168 = Hex 1c00
# 8190 = Hex 1FFE
# 0x10000 = Startup
#invoke2 -entry uprobe_console_trace -format int -int1 1
#invoke2 -entry eioevent_trace -format int -int1 7168
#invoke2 -entry inc_trace -format int -int1 8190
#invoke -entry PnetTrace -arg 0x10000 -nomode

# Spawn driver tasks
task -slotname PN_Tick -entp PnetTick -pri 44 -vwopt 0x1c -stcks 5000 -nosync -auto -noreg
task -slotname PnetReadts -entp PnetTaskRead -pri 72 -vwopt 0x1c -stcks 18000 -nosync -auto -noreg
task -slotname Pnetts -entp PnetTask -pri 122 -vwopt 0x1c -stcks 50000 -nosync -auto -noreg
task -slotname PnetCmdts -entp PnetTaskCmd -pri 123 -vwopt 0x1c -stcks 18000 -nosync -auto -noreg

# Register driver
invoke -entry incInstallDriver -strarg "PROFINET_INC,PnetDriverEntry,PnetOutputEntry,BitMapped" -nomode

echo -text "... Done"
###################################################################################


ifvc -label VC_SKIP_CLOCK
invoke2 -entry ieee1588SelectClock -format "int" -int1 1
#VC_SKIP_CLOCK
synchronize -level task
go -level task
invoke -entry read_init
iomgrinstall -entry ici_fbc -name /ici_fbc
creat -name /ici_fbc/ICI: -pmode 0
ifvc -label VC_SKIP_PIB
invoke2 -entry ici_fbc_wait_for_online -format "char*,int" -str1 "192.168.126.200" -int1 60
#VC_SKIP_PIB

direxist -path ipsdata -label EXPORT_NFS
goto -label SKIP_NFS
#EXPORT_NFS
invoke -entry pntsup_nfs_start
invoke2 -entry pntsup_nfs_export_home -format "char*" -str1 "ipsdata"
#SKIP_NFS

invoke2 -entry print_rapid_errors -format int -int1 1


ifvc -label VC_SKIP_PIB
invoke -entry eio_synchronize_device_as_local -strarg "PibSaf" -nomode
#VC_SKIP_PIB

ifvc -label VC_SKIP_PIB
task -slotname pntresetpibts -slotid -1 -pri 100 -vwopt 0x1c -stcks 9000 \
-entp pntresetpibts -nosync -auto -noreg
#VC_SKIP_PIB

task -slotname pntcmdts -slotid -1 -pri 140 -vwopt 0x1c -stcks 20000 \
-entp pntcmdts -nosync -auto -noreg

invoke -entry pntloop_init

invoke -entry pntprot_data_init
invoke -entry pntprot_cmd_init
invoke -entry pntprot_client_init
task -slotname pntprot_client_ts -slotid -1 -pri 120 -vwopt 0x1c -stcks 9000 \
-entp pntprot_client_ts -nosync -auto -noreg
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 101
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 102
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 106
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 141
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 303
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 306
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 315
