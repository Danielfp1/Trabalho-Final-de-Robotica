MODULE Module1
	CONST robtarget PontoDeSeg:=[[508.77,132.09,531.52],[0.542983,-0.16391,0.815099,0.117972],[0,0,-1,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
    CONST robtarget PontoEmCimaPega:=[[478.37,115.95,462.24],[0.239299,-0.305009,0.921792,0.00209509],[0,0,-1,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
	CONST robtarget PontoPega:=[[478.37,115.95,271.69],[0.239299,-0.305009,0.921792,0.00209507],[0,0,-1,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
	CONST robtarget PontoDeixa:=[[-251.95,-456.15,249.96],[0.166053,0.435105,0.869081,-0.166757],[-2,0,-2,0],[9E+9,9E+9,9E+9,9E+9,9E+9,9E+9]];
	
    !***********************************************************
    !
    ! Module:  Module1
    !
    ! Description:
    !   <Insert description here>
    !
    ! Author: Daniel
    !
    ! Version: 1.0
    !
    !***********************************************************
    
    
    !***********************************************************
    !
    ! Procedure main
    !
    !   This is the entry point of your program
    !
    !***********************************************************
    PROC main()
        !Add your code here
        MoveJ PontoDeSeg, v1000, z50, tool0;
        Loop:
        Reset DOLarga;
        Reset DOPega;
        IF TestDI(DIRobo2) THEN
            WaitTime 1;
            MoveL PontoPega, v1000, z50, tool0;
            WaitTime 1;
            Set DOPega;
            MoveL PontoEmCimaPega, v1000, z50, tool0;
            MoveL PontoDeixa, v1000, z50, tool0;
            WaitTime 1;
            Set DOLarga;
            MoveL PontoEmCimaPega, v1000, z50, tool0;
        ENDIF
        GOTO Loop;
    ENDPROC
ENDMODULE