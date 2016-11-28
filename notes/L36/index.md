title = 'Analog-to-Digital and Digital-to-Analog Conversion. Lab 7 / 8 Intro.'

# Lesson 36 Notes

## Readings
- Barrett 8.1-8.5 (pp241-259)
- [Temperature Sensor Datasheet - LM34](/382/datasheets/lm34.pdf)
- [PPT Slides](Lsn36.pptx)
- [ECE 315 - ADC Lesson Reading](Lesson_17_AD_Conversion_I.pdf)
- [ADC Demo](ADC_Demo.pdf)

## Assignment
- [Temperature Sensor In-Class Exercise](Lsn36_in_class_exercise.docx)
- [Lab 7 Prelab](/382/labs/lab7/index.html)

## Lesson Outline
- Admin
- Robot Demo
- ADC Example Code
- The MSP430's ADC10
- Analog-to-Digital Conversion
- Digital-to-Analog Conversion
- [Lab 7](/382/labs/lab7/index.html) / [Lab 8](/382/labs/lab8/index.html) Introduction

## Admin

- Amazon Drone video!
  - http://www.youtube.com/watch?v=98BIu9dpwHU&feature=youtu.be
  - You better believe there are microcontrollers in that thing!

This is our last in-class lesson of the year!  I'm going to experiment with a new approach today - let me know what you think!

This lesson used to show how to use the robot sensors to detect walls and move the robot accordingly.  However, with the new sensors, this is no longer the case.  

Each has an IR emitter and IR sensor.  The idea is that the closer the wall gets, the more radiation from the emitter will be reflected off the wall and into the sensor.  The amount of radiation detected is proportional to the amount of voltage the sensor emits.  So voltage increased as the wall moved closer and decreased as it got further away.

## ADC Example Code from old robot

Let's take the first sensor readings from our robot.  This code monitors A4, located on P1.4.  If the voltage on that pin is above the threshold 0x1FF, it sets P1.0 (an LED on the Launchpad).  Otherwise, it clears it.

Let's run the code!  Later I'll go through it line-by-line.

*[Demo on robot - hook up DMM to measure voltage into A-to-D]*

```c
// TI example code

#include <msp430g2553.h>

void main(void)
{
  WDTCTL = WDTPW + WDTHOLD;                 // Stop WDT
  ADC10CTL0 = ADC10SHT_3 + ADC10ON + ADC10IE; // ADC10ON, interrupt enabled
  ADC10CTL1 = INCH_4;                       // input A4
  ADC10AE0 |= BIT4;                         // P1.4 ADC Analog Enable
  ADC10CTL1 |= ADC10SSEL1|ADC10SSEL0;				// Select SMCLK
  P1DIR |= 0x01;                            // Set P1.0 to output direction

  while(1)
  {
    ADC10CTL0 |= ENC + ADC10SC;             // Sampling and conversion start
    __bis_SR_register(CPUOFF + GIE);        // LPM0, ADC10_ISR will force exit
    if (ADC10MEM < 0x1FF)
      P1OUT &= ~0x01;                       // Clear P1.0 LED off
    else
      P1OUT |= 0x01;                        // Set P1.0 LED on
  }
}

// ADC10 interrupt service routine
#pragma vector=ADC10_VECTOR
__interrupt void ADC10_ISR(void)
{
  __bic_SR_register_on_exit(CPUOFF);        // Clear CPUOFF bit from 0(SR)
}
```

So how does this work on the MSP430?

## The MSP430's ADC10

In the above code, we used the MSP430's ADC10 subsystem to take the readings - the 10 indicates the number of bits of resolution we have to represent each sample.

If we have 10 bits, what's the highest value our ADC can return?  0x3FF!

Let's walk through the code and see what each line is doing.

`ADC10CTL0 = ADC10SHT_3 + ADC10ON + ADC10IE; // ADC10ON, interrupt enabled`

So we're setting some bits in the `ADC10CTL0` register - what are these bits doing?  Let's check out the register:

![ADC10CTL0 Register](ADC10CTL0.jpg)
![ADC10CTL0 Register Continued](ADC10CTL0-cont.jpg)

`ADC10CTL0 = ADC10SHT_3 + ADC10ON + ADC10IE; // ADC10ON, interrupt enabled`

`ADC10SHT_3` controls the amount of time per sample.  Section 22.2.5.1 of the Family Users Guide gives more information on this.  Essentially, the higher the input impedance seen by the chip, the longer you'll need to sample to get an accurate reading.  You can view the input pin as a low-pass filter.  On our robots, input impedance changes based on the amount of light reflected - it gets lower if more light is reflected.  There is **significant** loading at low voltages.  **My advice would be to choose the longest possible sampling period to be safe.**  This also means that your ADC will be more accurate at close distances.  You can tell you have loading if the voltage reading changes when you plug it into the chip.

`ADC10ON` turns the subsystem on.  `ADC10IE` enables the corresponding interrupt.

```c
  ADC10CTL1 = INCH_4;                       // input A4
  ADC10AE0 |= BIT4;                         // P1.4 ADC Analog Enable
  ADC10CTL1 |= ADC10SSEL1|ADC10SSEL0;       // Select SMCLK
  P1DIR |= 0x01;                            // Set P1.0 to output direction
```

So we're setting bits in the `ADC10CTL1` and `ADC10AE0` registers - let's take a look at those.

![ADC10CTL1 Register](ADC10CTL1.jpg)
![ADC10CTL1 Register Continued](ADC10CTL1-cont.jpg)

![ADC10AE0 Register](ADC10AE0.jpg)

```c
  ADC10CTL1 = INCH_4;                       // input A4
  ADC10AE0 |= BIT4;                         // P1.4 ADC Analog Enable
  ADC10CTL1 |= ADC10SSEL1|ADC10SSEL0;       // Select SMCLK
  P1DIR |= 0x01;                            // Set P1.0 to output direction
```

`ADC10CTL1 = INCH_4;` selects the input channel to be A4.  There are many other options we can choose here, including an internal temperature sensor.

`ADC10AE0 |= BIT4;` this sets up A4 for analog input - disabling any internal chip components, etc. that could interfere. 

`ADC10CTL1 |= ADC10SSEL1|ADC10SSEL0;` selects the SMCLK to be our ADC clock source.  This runs at roughly 1MHz by default.  If we leave this unchanged, we'll use ADC10OSC as our clock source - which runs at roughly 5MHz.  This is also impacts our sample period - which is important depending on the impedance of our signal.  Remember the loading problems we talked about earlier?

`P1DIR |= 0x01;` just sets P1.0 to output so we can light up the LED on the Launchpad.

And now onto our `while` loop - that uses the ADC10MEM register:

```c
  while(1)
  {
    ADC10CTL0 |= ENC + ADC10SC;             // Sampling and conversion start
    __bis_SR_register(CPUOFF + GIE);        // LPM0, ADC10_ISR will force exit
    if (ADC10MEM < 0x1FF)
      P1OUT &= ~0x01;                       // Clear P1.0 LED off
    else
      P1OUT |= 0x01;                        // Set P1.0 LED on
  }



// ADC10 interrupt service routine
#pragma vector=ADC10_VECTOR
__interrupt void ADC10_ISR(void)
{
  __bic_SR_register_on_exit(CPUOFF);        // Clear CPUOFF bit from 0(SR)
}
```

![ADC10MEM Register](ADC10MEM.jpg)

`ADC10CTL0 |= ENC + ADC10SC;` - the ENC bit enables the core.  Control bits can only be modified when the core is disabled.  The ADC10SC bit tells the core to begin a sample-and-conversion sequence.

`__bis_SR_register(CPUOFF + GIE);` - here's some low-power code!  We're going to turn off the CPU and enable interrupts.

When the interrupt is triggered, we'll execute `__bic_SR_register_on_exit(CPUOFF);`, re-enabling the CPU and executing our next instructions.

Finally, we'll read the sample we took in via `if (ADC10MEM < 0x1FF)` - `ADC10MEM` is where our sample is stored. We'll use the reading to light the LED if it's above a threshold.

But how does the underlying technology work?

## Analog-to-Digital Conversion

![Analog to Digital Conversion](ATD.png)

Some questions:

- If we have a 10 bit ADC, how many unique values can we represent?
- What's better a smaller resolution or larger resolution?
- How can we improve resolution?  This is important on the robot - better resolution means you'll be able to see walls sooner.

### ATD Technologies

On our chip, we have a Successive Approximation ADC.

![Successive Approximation ADC](successive_approximation.png)

### Digital-to-Analog Conversion

Your chips do not have Digital-to-Analog hardware on board, but they're out there!

![Digital to Analog Conversion](DTA.png)

How would the robot motion lab have been easier if you had access to a DAC?

## Lab 7 / 8 Introduction

[Lab 7](/382/labs/lab7/index.html)


#### General advice about living in the moment and not looking to future events to fix your problems.

http://www.thisamericanlife.org/radio-archives/episode/494/hit-the-road - 2030-2400


