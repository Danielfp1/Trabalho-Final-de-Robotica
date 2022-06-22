
invoke -entry pntsaf_reset_sys_fail_signal -nomode
invoke -entry pntsaf_enable1O_close -nomode

invoke -entry pntprot_eio_set_startup_finished
invoke -entry pntprot_ra2_update_pib_ip

fileexist -path startcust.cmd -label START_CUST
goto -label NO_START_CUST
#START_CUST
include -path startcust.cmd
#NO_START_CUST
