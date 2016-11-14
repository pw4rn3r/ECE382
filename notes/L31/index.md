title = 'Timer_A: Capture / Compare, Pulse Width Modulation.  Lab 6 Introduction.'

# Lesson 32 Notes

## Readings
- Barrett 6.5 (pp175-177)
- [Intro to Pulse Width Modulation](http://www.embedded.com/electronics-blogs/beginner-s-corner/4023833/Introduction-to-Pulse-Width-Modulation)
- [MSP430: Timers and Clocks and PWM!  Oh My!](http://www.msp430launchpad.com/2010/07/timers-and-clocks-and-pwm-oh-my.html)
- [PPT Slides](Lsn32.pptx)

## Assignment
- [Lab 6 Prelab](/382/labs/lab6/index.html)

## Lesson Outline
- Admin
- Lab 6 Introduction
- Pulse Width Modulation
- Capture / Compare
- Example
- Lab 6 Tips

## Admin

- Video
- L33 we start on the robot!

## Lab 6 Introduction

Next lesson, you're going to start work on the robot.  Eventually, you'll use the MSP430 to power it to navigate a maze.  But first, we have to learn how to use the onboard motors to move our robot forward, back, left and right - that's the crux of Lab 6.

How do you move a DC motor?  You apply an analog voltage!

*[Demo motor with power supply]*

But how can we do this with the MSP430?  GPIO only gives us logical 1 or 0.  We don't have an onboard Digital-to-Analog converter.  Say we want to generate an analog output using our MSP430 - how would we do it?  The technique we'll learn today and use in Lab 6 is called Pulse Width Modulation.

## Pulse Width Modulation

Imagine a light bulb that is on 50% of the time and off 50% of the time.  *[Draw waveform with 50% duty cycle on the board]*.

*[Turn classroom lights on and off]*

If the frequency of the change is very slow, it would be very noticeable that we're just switching between two digital states.

But what if the frequency was very fast?  It would just appear as a light with 50% brightness!  It would appear like an analog voltage of 50% of the high voltage, providing 50% power.

To change the brightness of the bulb, we can change the percentage of the period the signal is high!  Assuming our logic high is 5V.  If our signal was high 10% of the time, it would look like a 0.5V analog signal.  50% of the time would look like a 2.5V analog signal.  100% of the time would look like the full 5V analog signal.

We call the percentage of a period the signal is high the signal's **duty cycle**.

Here's a demo of me switching between different duty cycles to power an LED:

*[LED with PWM demo]*

See how the brightness of the LED varies?

Let's see how it looks on the multimeter!

*[Hook up to DMM]*

See how the voltage changes, but reaches a steady analog state each time?

Let's see how it looks on a scope.

*[Hook up to O-Scope]*

See how it's actually just a recurring signal with a specified percentage high?  See how the percentage of time it's high controls the voltage?  Sweet!

### Terminology

- Period
	- Time interval over which a clock repeats itself
- Duty Cycle
	- Percentage of time a clock signal is logic high

## Capture / Compare

Ok, back to the technical stuff.

In addition to what we talked about last time, Timer_A comes equipped with three Capture/Compare blocks.

Back to our trusty block diagram.  Today we'll be looking at the bottom:

![Timer A Block Diagram](/382/notes/L25/timerA_block_diagram.jpg)

**Capture:** Monitor a pin for a specified signal (rising edge, falling edge, either edge) and record when it occurs.

**Compare:** Generate a specified signal with precise timing.

Here's how those registers are configured:

![TACCTL Register Description](TACCTL_register.jpg)

### Capture

Capture mode is selected when the CAP bit in TACCTL is set to 1.  It is used to record time events.  It can be used for:

- Event detection
- Event counting
- Pulse-width measurement
- Frequency measurement

Each TACCRx has two possible capture pins - CCIxA and CCIxB.  The one being monitored is selectable by software.  In the device-specific guide, you can find more information on which timer signals these inputs correspond with in the pin functions, terminal functions, and the timer signal connections tables.

If a capture occurs:

	- The TAR value is copied into the TACCRx register
	- The interrupt flag CCIFG is set

You could measure the time between a rising edge on two different signals, for example, or you could measure how long a particular signal is high.  If you are measuring the time between two events, it is recommended that you use Timer_A in the continuous mode.  (What capture mode is this?)  Your TAR could overflow once or even multiple times between the two events; you will know an overflow happened if the COV bit was set in the TACCTLx register.  If you are in up mode, dealing with the differences in TARs could be a little more difficult.  Look at the state diagram below to figure out how to deal with the COV bit.

![Capture Cycle](capture_cycle.jpg)

You can use your Timer_A interrupt to help you in your quest for an input capture, as long as you enable the capture/compare interrupt.  Note another bit in the TACCTLx register: CCI.  TI says this bit is the "capture/compare input.  The selected input signal can be read by this bit."  In other words, you can see the value of the signal you are watching.  Why does that matter?  If you are measuring the time a signal is high using CM_3, you will need to differentiate between the TAR at the start of the rising edge and the TAR at the falling edge.  Checking the CCI bit will tell you which edge you just left, which might be important inside an interrupt.  However, the CCI bit can also get into a race condition; for this reason it is important that you synchronoize your capture with the timer clock.


### Compare

Compare mode is selected when the CAP bit in TACCTL is set to 0 (it's 0 by default).

Remember the different Timer_A counting modes from last lesson?

![Timer Modes](/382/notes/L25/timer_modes.jpg)

Remember Up Mode?

![Up Mode](/382/notes/L25/timer_up_mode.jpg)

It counts from 0 up to the value in TACCR0!  We can set the value in TACCR0 just by writing to it.

TimerA0 also comes equipped with two more Capture / Compare registers - TA0CCR1 and TA0CCR2.  We can set their values by writing to them as well.  These give us interesting capabilities.  While TimerA0 counts upward, these registers can perform actions when the values in them are passed.  Here's what they can do:

![Output Modes](output_modes.jpg)

That might be confusing.  Check out that example:

![Output Modes Example - Up Mode](up_mode_modes_example.jpg)

## Example Code

This is the code I used to light the LED at four different levels of brightness:

```
#include <msp430.h>

void main(void)
{
    WDTCTL = WDTPW|WDTHOLD;                 // stop the watchdog timer

    	P2DIR |= BIT1;                // TA1CCR1 on P2.1
        P2SEL |= BIT1;                // TA1CCR1 on P2.1
        P2OUT &= ~BIT1;

        TA1CTL |= TASSEL_2|MC_1|ID_0;           // configure for SMCLK
        P1DIR |= BIT0;            //use LED to indicate duty cycle has toggled
        P1REN |= BIT3;
        P1OUT |= BIT3;

        TA1CCR0 = 1000;                // set signal period to 1000 clock cycles (~1 millisecond)
        TA1CCR1 = 250;                // set duty cycle to 250/1000 (25%)
        TA1CCTL0 |= CCIE;        		// enable CC interrupts
        TA1CCTL1 |= OUTMOD_7|CCIE;        // set TACCTL1 to Set / Reset mode//enable CC interrupts
        TA1CCTL1 &= ~CCIFG;				//clear capture compare interrupt flag
    	_enable_interrupt();

    	while (1) {

            while (P1IN & BIT3);     //every time the button is pushed, toggle the duty cycle
            __delay_cycles(1000000);
            TA1CTL &= ~MC0;
            TA1CCR1 = 1000;            // set duty cycle to 1000/1000 (100%)
            TA1CTL |= MC_1;

            while (P1IN & BIT3);
            __delay_cycles(1000000);
            TA1CTL &= ~MC0;
            TA1CCR1 = 750;            // set duty cycle to 750/1000 (75%)
            TA1CTL |= MC_1;

            while (P1IN & BIT3);
            __delay_cycles(1000000);
            TA1CTL &= ~MC0;
            TA1CCR1 = 500;            // set duty cycle to 500/1000 (50%)
            TA1CTL |= MC_1;

            while (P1IN & BIT3);
            __delay_cycles(1000000);
            TA1CTL &= ~MC0;
            TA1CCR1 = 250;            // set duty cycle to 250/1000 (25%)
            TA1CTL |= MC_1;

            while (P1IN & BIT3);
            __delay_cycles(1000000);
            TA1CTL &= ~MC0;
            TA1CCR1 = 100;            // set duty cycle to 100/1000 (10%)
            TA1CTL |= MC_1;

            while (P1IN & BIT3);
            __delay_cycles(1000000);
            TA1CTL &= ~MC0;
            TA1CCR1 = 20;            // set duty cycle to 20/1000 (2%)
            TA1CTL |= MC_1;

        }
}


#pragma vector = TIMER1_A0_VECTOR			// This is from the MSP430G2553.h file
__interrupt void captureCompareInt (void) {
    P1OUT |= BIT0;						//Turn on LED
	// Disable Timer A Interrupt
    TA1CCTL1 &= ~CCIFG;				//clear capture compare interrupt flag
//	TACTL &= ~TAIFG;
}

#pragma vector = TIMER1_A1_VECTOR			// This is from the MSP430G2553.h file
__interrupt void captureCompareInt2 (void) {
    P1OUT &= ~BIT0;						//Turn off LED
	// Disable Timer A Interrupt
    TA1CCTL1 &= ~CCIFG;				//clear capture compare interrupt flag
//	TACTL &= ~TAIFG;
}
```




This is the code I used to show the PWM signals on the oscilloscope:

```
#include <msp430.h>

void main(void)
{
    WDTCTL = WDTPW|WDTHOLD;                 // stop the watchdog timer

	  P2DIR |= BIT1;                // TA1CCR1 on P2.1
        P2SEL |= BIT1;                // TA1CCR1 on P2.1
        P2OUT &= ~BIT1;
        TA1CTL |= TASSEL_2|MC_1|ID_0;           // configure for SMCLK
        P1DIR |= BIT0;			//use LED to indicate duty cycle has toggled
        P1REN |= BIT3;
        P1OUT |= BIT3;

        TA1CCR0 = 1000;                // set signal period to 1000 clock cycles (~1 millisecond)
        TA1CCR1 = 250;                // set duty cycle to 250/1000 (25%)
        TA1CCTL1 |= OUTMOD_3;        // set TACCTL1 to Set / Reset mode

        while (1) {

        	while (P1IN & BIT3);	//every time the button is pushed, toggle the duty cycle
        	__delay_cycles(1000000);
        	TA1CTL &= ~MC0;
	        TA1CCR1 = 500;            // set duty cycle to 500/1000 (50%)
	        TA1CTL |= MC_1;
	        P1OUT ^= BIT0;

	        while (P1IN & BIT3);
	    	__delay_cycles(1000000);
	    	TA1CTL &= ~MC0;
            TA1CCR1 = 750;            // set duty cycle to 750/1000 (75%)
            TA1CTL |= MC_1;
            P1OUT ^= BIT0;

        	while (P1IN & BIT3);
        	__delay_cycles(1000000);
        	TA1CTL &= ~MC0;
            TA1CCR1 = 1000;            // set duty cycle to 1000/1000 (100%)
            TA1CTL |= MC_1;
            P1OUT ^= BIT0;

        	while (P1IN & BIT3);
        	__delay_cycles(1000000);
        	TA1CTL &= ~MC0;
            TA1CCR1 = 250;            // set duty cycle to 250/1000 (25%)
            TA1CTL |= MC_1;
            P1OUT ^= BIT0;

        	while (P1IN & BIT3);
        	__delay_cycles(1000000);
        	TA1CTL &= ~MC0;
            TA1CCR1 = 10;            // set duty cycle to 10/1000 (1%)
            TA1CTL |= MC_1;
            P1OUT ^= BIT0;
}
```

## Lab 6 Tips

### Motor Driver Chip

You cannot hook your MSP430 directly up to the motors - it can't supply enough current!  We need to use a motor driver chip instead.  It can only supply 1A per circuit!  Do not exceed that!  [Check out the datasheet for wiring details.](/382/datasheets/)

### Motor Stall Current

This is the max current draw your motor might have - usually happens when it runs up against the wall or something.  This better not exceed the 1A your motor driver chip can supply or you'll burn it!

*[Show technique to measure stall current]*

On my robot, the stall current does not go below one amp until my motor is being driven at 8V or less - roughly 60% duty cycle.  Exceed this at your own risk!

### MSP430 In-Circuit

**Supplying Power**

We have 3.3V regulators!  Use them!  If you try to give 5V to your MSP430, you will fry it!  [Check out the datasheet for wiring details.](/382/datasheets/)

**Programming**

See the tutorial on the website!  You can just jump the VCC / TEST / RESET signal over to the chip on the breadboard.

### Chip Reset Due to Current Fluctuation

If the motors draw a large amount of current (due to stall), there is a good chance it will interfere with the current provided to your MSP430.  To combat this, you can put a large capacitor across the 5V rail (between power and ground).  This will supplement the lost current and prevent your chip from being reset.
