module calpos

   ! SCOPE: Universal calibration/sync position program.

   proc mainCalPos()
      var jointtarget jLocalCalPos;
      
      ! Dummy instruction for SetPP.
      WaitTime 1;

      ! Set default values for all axis.
      jLocalCalPos := [[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09],[9E+09,9E+09,9E+09,9E+09,9E+09,0]];

      jLocalCalPos.robax.rax_1 := nArmCalPos("rob1_1");
      jLocalCalPos.robax.rax_2 := nArmCalPos("rob1_2");
      jLocalCalPos.robax.rax_3 := nArmCalPos("rob1_3");
      jLocalCalPos.robax.rax_4 := nArmCalPos("rob1_4");
      jLocalCalPos.robax.rax_5 := nArmCalPos("rob1_5");
      jLocalCalPos.robax.rax_6 := nArmCalPos("rob1_6");

      if nRobSerialPart() = 5500 or nRobSerialPart() = 5510 then
         ! IRB5500 and IRB5510 has special values on axis 5 and 6, just set to 0 as stated in the manual.
         jLocalCalPos.robax.rax_5 := 0;
         jLocalCalPos.robax.rax_6 := 0;
      endif
      
      if stSingleJoint("AX7_1") <> "" then
         ! 7-axis robot.
         jLocalCalPos.extax.eax_a := nArmCalPos(stSingleJoint("AX7_1") \NoConversion)*1000;
      elseif nArmCalPos("obp_3") <> 9E+09 then 
         ! 3-axis TurnTable.
         !IndReset OBP,2\RefNum:=0\Short;
         !IndReset OBP,3\RefNum:=0\Short; 
         jLocalCalPos.extax.eax_a := nArmCalPos("obp_1");
         jLocalCalPos.extax.eax_b := nArmCalPos("obp_2");
         jLocalCalPos.extax.eax_c := nArmCalPos("obp_3");
      elseif nArmCalPos("obp_2") <> 9E+09 then 
         ! 2-axis TurnTable.
         jLocalCalPos.extax.eax_a := nArmCalPos("obp_1");
         jLocalCalPos.extax.eax_b := nArmCalPos("obp_2");
      elseif nArmCalPos("obp_1") <> 9E+09 then 
         ! 1-axis TurnTable.
         jLocalCalPos.extax.eax_a := nArmCalPos("obp_1");
      elseif nArmCalPos("track1") <> 9E+09 then 
         ! IRB5350-02.
         jLocalCalPos.robax.rax_4 := 0;
         jLocalCalPos.robax.rax_5 := 0;
         jLocalCalPos.robax.rax_6 := 0;
         jLocalCalPos.extax.eax_a := nArmCalPos("track1" \NoConversion);
      elseif stRobotType() = "ROB1_5350_01_T00F82_A21C21D21" then
         ! IRB5350-01.
         jLocalCalPos.robax.rax_4 := 0;
         jLocalCalPos.robax.rax_5 := 0;
         jLocalCalPos.robax.rax_6 := 0;
      elseif stRobotAx7Type() = "PNT_5500_ROT_AX7" then
         ! IRB5500-27.
         jLocalCalPos.extax.eax_a := 0;
         jLocalCalPos.extax.eax_b := 0;
      else
         ! Attempt to get values for 8-axis robot.
         jLocalCalPos.extax.eax_a := nArmCalPos("rob1_7" \NoConversion);
         jLocalCalPos.extax.eax_b := nArmCalPos("rob1_8" \NoConversion);
      endif

      if stSingleJoint("H1AngleAxis") <> "" then
         ! Global CBS.
         jLocalCalPos.extax.eax_b := 0;
         jLocalCalPos.extax.eax_c := 0;
         jLocalCalPos.extax.eax_d := 0;
         jLocalCalPos.extax.eax_e := 0;
      endif

      MoveAbsJ jLocalCalPos,v100,fine,tool0;
      Stop;
   endproc

   local func num nArmCalPos(string stArm \switch NoConversion)
      var num nCalPos;
      ReadCfgData "/MOC/ARM/" + stArm, "cal_position", nCalPos;
      if Present(NoConversion) then
         return nCalPos;
      else
         return Round(nCalPos * (180 / 3.1415926) \Dec := 3);
      endif
   error
      if errno = ERR_CFG_NOTFND then
         SkipWarn;
         return 9E+09;
      endif
   endfunc

   local func string stSingleJoint(string stSingle)
      var string stJoint;
      ReadCfgData "/MOC/SINGLE/" + stSingle, "use_joint", stJoint;
      return stJoint;
   error
      if errno = ERR_CFG_NOTFND then
         SkipWarn;
         return "";
      endif
   endfunc

   local func num nRobSerialPart()
      var string stPart;
      var num nPart;
      ReadCfgData "/MOC/ROBOT_SERIAL_NUMBER/PID", "robot_serial_number_high_part", stPart;
      if StrToVal(StrPart(stPart, 1, StrFind(stPart, 1, "_") - 1), nPart) then
         return nPart;
      else
         return 9E+09;
      endif
   error
      SkipWarn;
      return 9E+09;
   endfunc

   local func string stRobotType()
      var string stType;
      ReadCfgData "/MOC/ROBOT/ROB_1", "use_robot_type", stType;
      return stType;
   error
      if errno = ERR_CFG_NOTFND then
         SkipWarn;
         return "";
      endif
   endfunc

   local func string stRobotAx7Type()
      var string stType;
      ReadCfgData "/MOC/ROBOT/ROT_AX7", "use_robot_type", stType;
      return stType;
   error
      if errno = ERR_CFG_NOTFND then
         SkipWarn;
         return "";
      endif
   endfunc

endmodule
