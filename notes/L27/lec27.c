//-----------------------------------------------------------------
// Name:	Coulston
// File:	lec27.c
// Date:	Fall 2014
// Purp:	Edge sensitive interrupts
//-----------------------------------------------------------------
#include <msp430g2553.h>


#define		HIGH_2_LOW		P1IES |= BIT3
#define		LOW_2_HIGH		P1IES &= ~BIT3
void initMSP430();

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
void main(void) {

	initMSP430();				// Setup MSP to process IR and buttons

	while(1);

} // end main

// -----------------------------------------------------------------------
// -----------------------------------------------------------------------
void initMSP430() {

	IFG1=0; 					// clear interrupt flag1
	WDTCTL=WDTPW+WDTHOLD; 		// stop WD

	BCSCTL1 = CALBC1_8MHZ;
	DCOCTL = CALDCO_8MHZ;

	P1DIR &= ~BIT3;						// DIR=0 is an input
	P1REN |= BIT3;
	P1OUT |= BIT3;
	P1IFG &= ~BIT3;						// Clear any interrupt flag
	P1IE  |= BIT3;						// Enable PORT 1 interrupt on pin change
	HIGH_2_LOW;							// Look for a negative edge after reset

	P1DIR |= BIT0 | BIT6;				// Enable updates to the LED
	P1OUT &= ~(BIT0 | BIT6);			// An turn the LED off

	TA0CCR0 = 0xFFFF;					// set the roll-over period
	TA0CTL &= ~TAIFG;					// clear flag
	TA0CTL = ID_3 | TASSEL_2 | MC_1;		// Use 1:8 prescalar off MCLK and enable interrupts

	_enable_interrupt();

} // end initMSP430



#pragma vector = PORT1_VECTOR			// This is from the MSP430G2553.h file
__interrupt void pinChange (void) {

	//------------------------------------------------------------------------------
	// In the first IF case, the pin is now at logic 1.  Since the interrupt occurs
	// on a pin change, the pin must have been at logic 0 just prior to this, so
	// we are handling a positive edge
	//------------------------------------------------------------------------------
	if (P1IN & BIT3) {			// POSITIVE EDGE - button release
		TAR = 0x0000;			// reset the timer
		TA0CTL &= ~TAIFG;		// clear flag
		HIGH_2_LOW; 			// Set up pin interrupt on negative edge
	} else {					// NEGATIVE EDGE - button press
		TA0CTL &= ~TAIFG;		// clear flag
		TAR = 0x0000;			// time measurements are based at time 0
		LOW_2_HIGH; 			// Set up pin interrupt on positive edge
		P1OUT ^= BIT6;
	} // end if

	P1IFG &= ~BIT3;			// Clear PIN ISR flag

} // end pinChange ISR

