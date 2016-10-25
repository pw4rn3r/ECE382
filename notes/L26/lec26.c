//-----------------------------------------------------------------
// Name:	Coulston
// File:	lec26.c
// Date:	Fall 2014
// Purp:	Setup and run Timer A and generate interrupts
//-----------------------------------------------------------------
#include <msp430g2553.h>
void initMSP430();

// -----------------------------------------------------------------------
// main is just another function like all the rest - except this one
// is called once at startup.
// -----------------------------------------------------------------------
void main(void) {

	initMSP430();				// Setup MSP to process IR and buttons

	while(1);					// main is looking pretty slim - see ISR code

} // end main

// -----------------------------------------------------------------------
//	initMSP430
//	Turn off interrupts and WDT
//	Set the main oscillator to run at 8Mhz
//	Setup the timer to run in "UP" mode and generate TAIFG interrupt
//	Setup green LED as output
// -----------------------------------------------------------------------
void initMSP430() {

	IFG1=0; 					// clear interrupt flag1
	WDTCTL=WDTPW+WDTHOLD; 		// stop WD

	BCSCTL1 = CALBC1_8MHZ;
	DCOCTL = CALDCO_8MHZ;

	P1DIR |= BIT6;								// Set the green LED as an output

	TA0CCR0 = 0xFFFF;							// create a 16ms roll-over period
	TA0CTL &= ~TAIFG;							// clear flag before enabling interrupts = good practice
	TA0CTL = ID_3 | TASSEL_2 | MC_1 | TAIE;		// Use 1:8 prescalar off MCLK and enable interrupts
	_enable_interrupt();

} // end initMSP430

// -----------------------------------------------------------------------
//  Just toggle the green LED every time you visit - and of course clear
//	flag.  The name for the vector is not at all obvious.  I got some help
//	here: http://processors.wiki.ti.com/index.php/MSP430_FAQ#How_to_assign_the_correct_Timer_A_interrupt_vector.3F
// -----------------------------------------------------------------------
#pragma vector = TIMER0_A1_VECTOR				// This is from the MSP430G2553.h file
__interrupt void timerOverflow (void) {

	P1OUT ^= BIT6;						// This provides some evidence that we were in the ISR
	TA0CTL &= ~TAIFG;					// See what happens when you do not clear the flag
}
