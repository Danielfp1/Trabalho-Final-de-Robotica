MODULE m4
    LOCAL CONST robtarget Paint_10:=[[498.743494875,-249.999639638,-0.000355856],[0,0.000512373,0.999999869,0],[-1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Paint_40:=[[500.075664199,1050.000097836,-0.000355856],[0,0.000512373,0.999999869,0],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Paint_50:=[[400.075559403,1050.000097836,-0.000355856],[0,0.000512373,0.999999869,0],[0,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Paint_80:=[[398.743390079,-249.999639638,-0.000355856],[0,0.000512373,0.999999869,0],[-1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Paint_90:=[[298.743285283,-249.999639638,-0.000355856],[0,0.000512373,0.999999869,0],[-1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Paint_120:=[[300.075454607,1050.000097836,-0.000355856],[0,0.000512373,0.999999869,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Paint_130:=[[200.075349811,1050.000097836,-0.000355856],[0,0.000512373,0.999999869,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Paint_160:=[[198.743180487,-249.999639638,-0.000355856],[0,0.000512373,0.999999869,0],[-1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Paint_170:=[[98.743075691,-249.999639638,-0.000355856],[0,0.000512373,0.999999869,0],[-1,1,-2,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    LOCAL CONST robtarget Paint_200:=[[100.075245015,1050.000097836,-0.000355856],[0,0.000512373,0.999999869,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    PROC mainm4()

    ENDPROC
    PROC Chapa_Panel_1()
        Loop:
        Reset DOPintou;
        IF TestDI (DIIniciar) THEN
            !WaitDI DIIniciar,1;
            PaintL Paint_10,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            SetBrush 3\Y:=-100;
            SetBrush 1\Y:=900;
            PaintL Paint_40,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            PaintL Paint_50,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            SetBrush 3\Y:=900;
            SetBrush 1\Y:=-100;
            PaintL Paint_80,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            PaintL Paint_90,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            SetBrush 3\Y:=-100;
            SetBrush 1\Y:=900;
            PaintL Paint_120,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            PaintL Paint_130,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            SetBrush 3\Y:=900;
            SetBrush 1\Y:=-100;
            PaintL Paint_160,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            PaintL Paint_170,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            SetBrush 3\Y:=-100;
            SetBrush 1\Y:=900;
            PaintL Paint_200,v800,z100,ROBOBEL926_T_TD_150\WObj:=Workobject_Chapa;
            Set DOPintou;
            WaitTime 2;
        ENDIF
        GOTO Loop;
    ENDPROC
ENDMODULE