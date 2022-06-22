module m10001

   ! SCOPE: Motion program for home position.

   proc mainm10001()
      if jHomePos.robax.rax_1 = 9E+09 then
         ErrWrite \W, "Home position not taught!", "";
      else
         MoveAbsJ jHomePos,v300,fine,tUserTool0;
      endif
   endproc

endmodule
