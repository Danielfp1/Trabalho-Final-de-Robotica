
invoke -entry pwinst_init
invoke -entry pwinst_syminsdef
invoke -entry pwdatapr_init
invoke -entry pweqippr_init
invoke -entry pwprocpr_init
invoke -entry pwproc_init

invoke -entry pntsaf_init

ifvc -label VC_SKIP_PURGE
task -slotname pntpurgets -slotid -1 -pri 50 -vwopt 0x1c -stcks 9000 \
-entp pntpurgets -nosync -auto -noreg
invoke -entry purge_sync
#VC_SKIP_PURGE

# Wait for conveyor signals here to prevent internal errors from appearing.
ifvc -label CNV_SKIP
getkey -id "CnvMedia" -strvar $ANSWER -errlabel CNV_SKIP
invoke2 -entry ici_fbc_wait_for_signals_on_unit -format "char*,int" -str1 "CnvIf" -int1 1000060
#CNV_SKIP


invoke -entry rlpw_init

invoke -entry rlgpw_init

invoke -entry pntloop_log_init
invoke -entry pntloop_pp_init
sysdmp_add -name PNTLOOP_LOG -show pntloop_log_show
task -slotname pntloop_event_ts -slotid -1 -pri 120 -vwopt 0x1c -stcks 9000 \
-entp pntloop_event_ts -nosync -auto -noreg

# Set up PP callback first...
invoke -entry pntqueue_pp_init
# ...then initialize the queue and let it push the data to the callback.
invoke -entry pntqueue_init
sysdmp_add -name PNTQUEUE -show pntqueue_show

invoke -entry pntprogmap_init

invoke -entry pntexstart_init

invoke -entry pntapp_init
invoke -entry pntapp_bt_init
invoke -entry pntapp_track_init
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 355 -int2 30
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 360 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 361 -int2 5
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 321
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 360
invoke2 -entry pntprot_cmd_whitelist_add -format "int" -int1 361

invoke -entry pntprot_log_init
sysdmp_add -name PNTPROTLOG -show pntprot_log_show

ifvc -label VC_SKIP_PPNET
invoke -entry pntprot_net_init
task -slotname pntprot_net_ts -slotid -1 -pri 98 -vwopt 0x1c -stcks 9000 \
-entp pntprot_net_ts -nosync -auto -noreg
#VC_SKIP_PPNET

invoke -entry pntprot_eio_init
task -slotname pntprot_eio_ts -slotid -1 -pri 100 -vwopt 0x1c -stcks 9000 \
-entp pntprot_eio_ts -nosync -auto -noreg

invoke -entry pntprot_wrap_init

invoke -entry gk_paint_init
invoke -entry pntprot_ra2_init

invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 1 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 2 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 101 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 102 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 103 -int2 10
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 104 -int2 15
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 106 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 107 -int2 10
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 110 -int2 10
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 111 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 130 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 131 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 140 -int2 5
invoke2 -entry pntprot_cmd_rapid_command_override -format "int,int" -int1 141 -int2 5

task -slotname pntprot_cmd_ts -slotid -1 -pri 95 -vwopt 0x1c -stcks 9000 \
-entp pntprot_cmd_ts -nosync -auto -noreg

ifvc -label VC_SKIP_PNTSUP
task -slotname pntsup_psuchan_ts -slotid -1 -pri 90 -vwopt 0x1c -stcks 9000 \
-entp pntsup_psuchan_ts -nosync -auto -noreg
invoke -entry pntsup_power_error_init
#VC_SKIP_PNTSUP
