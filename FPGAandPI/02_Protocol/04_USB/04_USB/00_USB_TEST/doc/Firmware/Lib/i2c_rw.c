//-----------------------------------------------------------------------------
// File: i2c_rw.c
// Contents: 
//
// $Archive: /USB/Target/Lib/lp/i2c_rw.c $
// $Date: 8/12/03 3:32p $
// $Revision: 1 $
//
//
//-----------------------------------------------------------------------------
// Copyright 2003, Cypress Semiconductor Corporation
//
// This software is owned by Cypress Semiconductor Corporation (Cypress) and is
// protected by United States copyright laws and international treaty provisions. Cypress
// hereby grants to Licensee a personal, non-exclusive, non-transferable license to copy,
// use, modify, create derivative works of, and compile the Cypress Source Code and
// derivative works for the sole purpose of creating custom software in support of Licensee
// product ("Licensee Product") to be used only in conjunction with a Cypress integrated
// circuit. Any reproduction, modification, translation, compilation, or representation of this
// software except as specified above is prohibited without the express written permission of
// Cypress.
//
// Disclaimer: Cypress makes no warranty of any kind, express or implied, with regard to
// this material, including, but not limited to, the implied warranties of merchantability and
// fitness for a particular purpose. Cypress reserves the right to make changes without
// further notice to the materials described herein. Cypress does not assume any liability
// arising out of the application or use of any product or circuit described herein. Cypress’
// products described herein are not authorized for use as components in life-support
// devices.
//
// This software is protected by and subject to worldwide patent coverage, including U.S.
// and foreign patents. Use may be limited by and subject to the Cypress Software License
// Agreement.
//-----------------------------------------------------------------------------
#include <lp.h>
#include <lpregs.h>

BOOL EZUSB_ReadI2C(BYTE addr, BYTE length, BYTE xdata *dat)
{
	EZUSB_ReadI2C_(addr, length, dat);

	while(TRUE)
		switch(I2CPckt.status)
		{
			case I2C_IDLE:
				return(I2C_OK);
			case I2C_NACK:
				I2CPckt.status = I2C_IDLE;
				return(I2C_NACK);
			case I2C_BERROR:
				I2CPckt.status = I2C_IDLE;
				return(I2C_BERROR);
		}
}

BOOL EZUSB_WriteI2C(BYTE addr, BYTE length, BYTE xdata *dat)
{
	EZUSB_WriteI2C_(addr, length, dat);

	while(TRUE)
		switch(I2CPckt.status)
		{
			case I2C_IDLE:
				return(I2C_OK);
			case I2C_NACK:
				I2CPckt.status = I2C_IDLE;
				return(I2C_NACK);
			case I2C_BERROR:
				I2CPckt.status = I2C_IDLE;
				return(I2C_BERROR);
		}
}
