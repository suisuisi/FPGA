@echo off
REM #--------------------------------------------------------------------------
REM #	File:		BUILD.BAT
REM #	Contents:	Batch file to build frameworks lib for EZUSB FX2LP/FX1
REM #
REM # $Archive: $
REM # $Date:  $
REM # $Revision: $
REM #
REM #
REM #-----------------------------------------------------------------------------
REM # Copyright 2003, Cypress Semiconductor Corporation
REM #
REM # This software is owned by Cypress Semiconductor Corporation (Cypress) and is
REM # protected by United States copyright laws and international treaty provisions. Cypress
REM # hereby grants to Licensee a personal, non-exclusive, non-transferable license to copy,
REM # use, modify, create derivative works of, and compile the Cypress Source Code and
REM # derivative works for the sole purpose of creating custom software in support of Licensee
REM # product ("Licensee Product") to be used only in conjunction with a Cypress integrated
REM # circuit. Any reproduction, modification, translation, compilation, or representation of this
REM # software except as specified above is prohibited without the express written permission of
REM # Cypress.
REM #
REM # Disclaimer: Cypress makes no warranty of any kind, express or implied, with regard to
REM # this material, including, but not limited to, the implied warranties of merchantability and
REM # fitness for a particular purpose. Cypress reserves the right to make changes without
REM # further notice to the materials described herein. Cypress does not assume any liability
REM # arising out of the application or use of any product or circuit described herein. Cypress’
REM # products described herein are not authorized for use as components in life-support
REM # devices.
REM #
REM # This software is protected by and subject to worldwide patent coverage, including U.S.
REM # and foreign patents. Use may be limited by and subject to the Cypress Software License
REM # Agreement.
REM #-----------------------------------------------------------------------------

REM set EZTARGET=C:\Cypress\USB\CY3684_EZ-USB_FX2LP_DVK\1.0\Target
REM set C51INC=C:\Keil\C51\INC;%EZTARGET%\INC

REM ### Compile code ###
c51 resume.c debug oe code small moddp2 "ot(6,size)"
c51 discon.c debug oe code small moddp2 "ot(6,size)"
c51 delay.c debug oe code small moddp2 "ot(6,size)"
c51 ezregs.c debug oe code small moddp2 "ot(6,size)"
c51 i2c.c debug oe code small moddp2 "ot(6,size)"
c51 get_strd.c debug oe code small moddp2 "ot(6,size)"
c51 i2c_rw.c debug oe code small moddp2 "ot(6,size)"


REM ### Assemble  ###
a51 delayms.a51 debug errorprint nomod51
a51 susp.a51 debug errorprint nomod51
a51 USBJmpTb.a51 debug errorprint nomod51

if exist ezusb.lib del ezusb.lib
lib51 create ezusb.lib
lib51 add resume.obj to ezusb.lib
lib51 add discon.obj to ezusb.lib
lib51 add delay.obj to ezusb.lib
lib51 add ezregs.obj to ezusb.lib
lib51 add i2c.obj to ezusb.lib
lib51 add get_strd.obj to ezusb.lib
lib51 add i2c_rw.obj to ezusb.lib
lib51 add delayms.obj to ezusb.lib
lib51 add susp.obj to ezusb.lib

REM ### usage: build -clean to remove intermediate files after build
if "%1" == "-clean" del *.lst

:fini


