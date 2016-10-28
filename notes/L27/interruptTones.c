/*--------------------------------------------------------------------
Name: Capt Jeff Falkinburg
Date: 27 Oct 2016
Course: ECE 382
File: interruptTones.c
HW: Lesson 27

Purp: 	1. This C program utilizes interrupts to Blink the Green LED (P1.0 using Timer A at 440Hz
		2. Put a speaker or headphones on P1.6 to listen to the 440Hz 'A' Tone
		3. Implement another interrupt from a button press (P1.3) to toggle the Red LED (P1.0) and
		   increments to the next tone in the counts array.
		4. Use the button interrupt to increment through the counts array to be output the different
		   tones on a speaker.

Doc:  Lecture Notes for code and
	  I referenced frequencies for common musical notes on http://www.phy.mtu.edu/~suits/notefreqs.html

Academic Integrity Statement: I certify that, while others may have
assisted me in brain storming, debugging and validating this program,
the program itself is my own work. I understand that submitting code
which is the work of other individuals is a violation of the honor
code.  I also understand that if I knowingly give my original work to
another individual is also a violation of the honor code.
-------------------------------------------------------------------------*/
#include <msp430.h>
			//counts go from middle C and increments up two octaves
//unsigned int counts [25] = {0x1DDC,0x1C30,0x1A9B,0x191C,0x17B3,0x165F,0x151E,0x13EE,0x12D0,0x11C1,0x10C2,0x0FD2,0x0EEE,0x0E18,0x0D4D,0x0C8E,0x0BDA,0x0B2F,0x0A8F,0x09F7,0x0968,0x08E1,0x0861,0x07E9,0x0777};
unsigned int counts = 0x11C1; // Blink Green LED at 440 Hz or create an A tone at 440 Hz
/*
 * main.c
 */
void main(void) {

	WDTCTL = WDTPW | WDTHOLD;		// Stop watchdog timer

    P1DIR |= BIT6;				// Set P1.6 (Green LED) as an output

    BCSCTL1 = CALBC1_8MHZ;     		// Set SMCLK 8 MHz
    DCOCTL = CALDCO_8MHZ;
    								//2 Set up button
    P1DIR &= ~BIT3;					//2 Set up our P1.3 button
    P1REN |= BIT3;					//2 Enable pull up/down resistor
    P1OUT |= BIT3;					//2 Set as pull up yellow book (pp 39 or pp 329)

    								//2 Configure interrupt
    P1IES |= BIT3;					//2 Configure rising/falling edge triggered
    P1IFG &= ~BIT3;					//2 Clear P1.3 interrupt flag
    P1IE |= BIT3;					//2 Enable interrupts on BIT3 Port 1

    TA0CTL &= ~TAIFG;				// Turn off Timer A interrupt flag
    TA0CTL |= ID_3 | TASSEL_2 | MC_1 | TAIE;
    								// Setting all our bits count up to TA0CCR0
    TA0CCR0 = counts;				// Set Timer A 0 TA0CCR0 value
//    TA0CCR0 = counts [0];			// Set Timer A 0 TA0CCR0 value indexed into counts array
    __enable_interrupt();			// Enable Interrupts and then write function

    while (1);						// cpu trap
// Frequency Calculation Example: (See spreadsheet for all calculations)
// 8 *10^6 clks   1 cnt     4.545 ms (1/(440Hz/2))
// ------------ * ------ * --------------- 		= 4545 (0x11C1) cnts ==> (440hz)
//     1 s   	  8 clk    1 TAR roll over
}

#pragma vector = TIMER0_A1_VECTOR
__interrupt void timerOverFlow (void){
	TA0CTL &= ~TAIFG;				// Clears the interrupt flag to return
	P1OUT ^= BIT6;					// XOR Toggles our green LED on/off after timer
}

#pragma vector = PORT1_VECTOR
__interrupt void Port_1_ISR (void){
	P1IFG &= ~BIT3;					// Clears interrupt flag
}


