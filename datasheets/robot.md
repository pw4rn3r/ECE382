title = 'Using the MSP430 with the Robot'

# Using the MSP430 with the Robot

## Powering the MSP430

Your MSP430 cannot take the 5V available on the robot or it will burn out!  You have to use a part called a **regulator** that will take 5V in and output 3.3V.  Mr. Evans has LDV33 regulators available - [see the datasheets page](/382/datasheets) for more information.

## Programming the MSP430 In-Circuit
See [Programming the MSP430 In-Circuit](in_circuit_programming.html).

This tutorial was inspired by [this youtube video.](http://www.youtube.com/watch?v=dL2YPS96L18)

1.	Remove your MSP430 from your Launchpad and place it in the breadboard.
2.	Remove the TEST, RST, and VCC jumpers from your Launchpad.
3.	Connect wires to the TEST, RST, and VCC pins closest to the microUSB connector.
	- Connect TEST to Pin 17 of your MSP430
	- Connect RST to Pin 16 of your MSP430
	- Connect VCC to Pin 1 of your MSP430
4.	Connect the GND pin on your MSP430 to ground on your breadboard.
5.	Connect the VCC pin on your MSP430 to voltage on your breadboard - not more than 3.3V!

You're now ready to program your MSP430 in-circuit.  When you remove the USB cable, it will run under its own power!

## How It All Looks

![Top View of Assembled Robot with Annotations](robot_top.jpg)

**Red Circle** - decoupling capacitor placed across the 5V rail to prevent current fluctuation that may cause your MSP430 to reset.

**Light Blue Circle** - regulator that converts 5V to 3.3V to power your MSP430.  Hooking 5V directly up to your MSP430 would burn it!  See datasheet for more info.

**Pink Circle** - An MSP430!  For this lab, it might be beneficial to place your MSP430 chip in the breadboard and use the Launchpad as an in-circuit programmer (see tutorial).

**Purple Circle** - Wiring the programming pins form the Launchpad board to the appropriate pins on the MSP430 (see tutorial).  Note how there is no chip in the Launchpad - I'm placing it in the port on the robot purely as a holder.

**Orange Circle** - The motor driver chip!  This allows your MSP430 to control the motors without burning up due to the current requirements.  See datasheet for more info.
