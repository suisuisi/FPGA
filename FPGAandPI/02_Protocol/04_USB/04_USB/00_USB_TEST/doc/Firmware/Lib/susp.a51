;;-----------------------------------------------------------------------------
;; File: susp.a51
;; Contents: 
;;
;; $Archive: /USB/Target/Lib/lp/susp.a51 $
;; $Date: 5/27/04 2:07p $
;; $Revision: 2 $
;;
;;
;;-----------------------------------------------------------------------------
;; Copyright 2003, Cypress Semiconductor Corporation
;;-----------------------------------------------------------------------------
NAME     SUSP
PUBLIC      EZUSB_SUSP

$include (lpregs.inc)

EZUSB    segment  code

      rseg  EZUSB    
EZUSB_SUSP: 
   mov   dptr,#WAKEUPCS    ; Clear the Wake Source bit(s) in
   movx  a,@dptr           ; the WAKEUPCS register
   orl   a,#0C0H           ; clear PA2 and WPIN
   movx  @dptr,a
   
   mov   dptr,#SUSPEND     ; 
   movx  @dptr,a           ; write any walue to SUSPEND register
   
   orl   PCON,#00000001b   ; Place the processor in idle
   
   nop                     ; Insert some meaningless instruction
   nop                     ; fetches to insure that the processor
   nop                     ; suspends and resumes before RET
   nop
   nop
er_end:     ret
   end

