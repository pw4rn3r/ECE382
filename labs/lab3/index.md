
title = 'Lab 3 - SPI - "I/O"'

# Lab 3 - SPI - "I/O"

## Given code
- color.h - lists some of the colors at your disposal on the LCD
- lab3_given.asm

##  Mega Prelab
A hard copy of this Mega Prelab is required to be turned in.  Answers should not be handwritten.  The timing diagram may be NEATLY drawn by hand with the assistance of a straightedge on engineering paper.

### Delay Subroutine
In lab3_given.asm, you have the header for a subroutine, but there is no code.  Write a subroutine that will create a 160ms delay.  Show your analysis that proves the delay is indeed very close to 160 ms.

### ILI9341 LCD BoosterPack 

Look at the schematic for the LCD BoosterPack. Complete the following table.  The pin number (1 - 20) should be the pin number that signal connects to on the MSP 430. Describe the bit settings for each button in the three registers listed (see pages 328 and 329 of the MSP430g2553 User's Guide). <br>

| Name | Pin # | 
|:-: | :-: | 
| S1 |   |   
| S2 |   |   
| S3 |   |   
| S4 |	| 
| S5 |	| 

Hex values for
	- PxDIR:
	- PxREN:
	- PxOUT:


### Configure the MSP430

Look at the initMSP subroutine in the lab3_given.asm file.  There are four pins being intialized on port 1: SCLK, CS, MOSI, and DC.  What is the pin number (1-20) associated with each of these signals?  What function does each signal serve?  For example, SCLK is the serial clock.
| Name | Pin # | Function|
|:-: | :-: |:-: |
| SCLK |   |   |
| CS |   |   |
| MOSI |   |   |
| DC |	| |

Below the pin configuration code are some lines of code from the lab3_given.asm file to properly configure the SPI subsystem.  Use this code to answer the next two questions.
```
1:		bis	#LCD_SCLK_PIN|LCD_MOSI_PIN|LCD_MISO_PIN, &P1SEL
2:		bis	#LCD_SCLK_PIN|LCD_MOSI_PIN|LCD_MISO_PIN, &P1SEL2
3:		mov 	#UCCKPH|UCMSB|UCMST|UCSYNC, &UCB0CTL0
4:		bis 	#UCSSEL_2, &UCB0CTL1
5:		bis 	#BIT0, &UCB0BR0
6:		clr	&UCB0BR1
7:		bic	#UCSWRST, &UCB0CTL1
```
Fill in the chart below with the function that is enabled by the first two lines of the above code.  Your device-specific datasheet can help.
| Pin name | Function |
| :-:|:-:|
| P1.5| |
| P1.7| |
| P1.6| |

Next, describe what happens in each of the five subsequent lines of code above.  Line 4 has been done for you as an example.
Line 3:<br>
Line 4: The UCSSEL_2 setting for the UCB0CTL1 register has been chosen, selecting the SMCLK (sub-main clock) as the bit rate source clock for when the MSP 430 is in master mode.
Line 5: <br>
Line 6: <br>
Line 7: <br>

### Communicate with the LCD
The following code sends one byte (either data or command) to the TM022HDH26 display using its 8-bit protocol.  

```
;-------------------------------------------------------------------------------
;	Name: writeCommand
;	Inputs: command in r12
;	Outputs: none
;	Purpose: send a command to the LCD
;	Registers: r12 preserved
;-------------------------------------------------------------------------------
writeCommand:
	push	r12
	bic 	#LCD_CS_PIN, &P1OUT
	bic		#LCD_DC_PIN, &P1OUT
	mov.b	 r12, &UCB0TXBUF

pollC:
	bit		#UCBUSY, &UCB0STAT	;while UCBxSTAT & UCBUSY
	jnz		pollC

	bis		#LCD_CS_PIN, &P1OUT
	pop		r12
	ret

;-------------------------------------------------------------------------------
;	Name: writeData
;	Inputs: data to be written in r12
;	Outputs: none
;	Purpose: send data to the LCD
;	Registers: r12 preserved
;-------------------------------------------------------------------------------
writeData:
	push	r12
	bic 	#LCD_CS_PIN, &P1OUT
	bis	#LCD_DC_PIN, &P1OUT
	mov.b 	r12, &UCBxTXBUF

pollD:
	bit	#UCBUSY, &UCBxSTAT	;while UCBxSTAT & UCBUSY
	jnz	pollD

	bis	#LCD_CS_PIN, &P1OUT
	pop	r12
	ret
```

Use this code to draw two timing diagrams (one for each subroutine) of the expected behavior of LCD_CS_PIN, LCD_DC_PIN, LCD_SCLK_PIN, and UCBxTXBUF from the begining of these subroutines to the end.  Make sure that you clearly show the relationship of the edges in the clk and data waveforms. 


### Draw a pixel
The following code draws a pixel of a predetermined color at the coordinate (R12, R13).  However, four subroutines are called to execute this seemingly simple task.  Explain the purpose of each of the four subroutine calls:

|Subroutine| Purpose|
|:-:|:-:|
|setArea| |
|splitColor| |
|writeData| |
|writeData| |
```
;-------------------------------------------------------------------------------
;	Name: drawPixel
;	Inputs: x in r12, y in r13
;	Outputs: none
;	Purpose: draws a pixel in a particular spot
;	Registers: r12, 13, 14, 15 preserved
;-------------------------------------------------------------------------------
drawPixel:
	push	r12
	push	r13
	push	r14
	push	r15
	mov.b	r12, r14
	mov.b	r13, r15
	call	#setArea
	mov		#COLOR1, r12
	call	#splitColor
	call	#writeData
	mov		r13, r12
	call	#writeData
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	ret
```

(This marks the end of the Mega Prelab.)
---------------------------------------------------------------
## Logic Analyzer
The answers to the logic analyzer section will be posted to GitHub along with the functionality code.
###Physical communication
Connect the Nokia 1202 Booster Pack to your TI Launch Pad.  Make sure that the buttons on the Booster Pack are pointed away from the USB connector (and on the same side of the board as the MSP430 buttons), just like in the following picture.
![Board connection](connection.jpg)<br>
Download <a href="lab3.asm">lab3.asm</a> and build a project around the file.
Run the program and observe the output on the LCD every time you press the SW3 button.  It should look something like the following image after a few button presses.<br>
![test program](screen.jpg)<br>
When SW3 is detected as being pressed and released (lines 56-62), the MSP430 generates 4 packets of data that are sent to the Nokia 1202 display, causing a vertical bar to be drawn. Complete the following table by finding the 4 calls to writeNokiaByte that generate these packets. In addition, scan the nearby code to determine the parameters being passed into this subroutine. Finally, write a brief description of what is trying to be accomplished by each call to writeNokiaByte.

|Line|R12|R13|Purpose|
|:-:|:-:|:-:|:-:|
|||||
|||||
|||||
||||||
Configure the logic analyzer to capture the waveform generated when the SW3 button is pressed and released. Decode the data bits of each 9-bit waveform by separating out the MSB, which indicates command or data. Explain how the packet contents correspond to what was drawn on the display.  Be specific with the relationship between the data values and what and where the pixels are drawn

|Line|Command/Data|8-bit packet|
|:-:|:-:|:-:|
||||
||||
||||
|||||
Hint: in order to probe the signals while the LCD is connected to the LaunchPad, you will need to use the LaunchPad header pins with the probe hook grippers. Be careful when attaching and detaching the grippers to the pins, as they may easily bend and then no longer serve you well. Also, don't forget the ground pin!<br>
![Logic analyzer connection](left.jpg)<br>
You will get a waveform similar to that shown below. Note that the command/data bit is significantly far away from the 8 data bits. <br>
![Logic analyzer output](LA_datastream.jpg)<br>
Next, setup the Logic Analyzer to capture the RESET signal on a falling edge. Measure the duration that the RESET line is held low in the initNokia subroutine. Hint, the code to hold the reset line low can be found on lines 93-100. 
How many counts does the firmware loop count down from? 
Using the delay you just measured and the number of counts, calculate the amount of time each iteration of the delay loop consumes.

###Writing modes
The native write operation to the Nokia 1202 will overwrite any information that is was on the display with new information.  However, that may not be the best course of action in your application.  The new bits being added to the image may be merged using the AND, OR, XOR operators.  To do this treat a black pixel as a logic 1 and a white pixel as a logic 0.  The pixel values from the same locations are combined using a logical operator and placed at the corresponding location in the destination imaged.
Import the following image into a paint program and show the result of the operation between the two bits maps combined using the logic operator specified.
![xor picture](bitblock.bmp)
## Functionality
**Required functionality**: Create a block on the LCD that is 10x10 pixels.  <br>
**A functionality**: Move the 10-pixel block one block in the direction of the pressed button (up, down, left, right).  Do not allow the shadow to remain.


## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Mega Prelab | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days | | 20 | | EOC L16 |
| Required Logic Analyzer | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 40 | | COB L19 |
| Required Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 20 | | COB L19 |
| A Functionality | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L19 |
| Lab Notebook | **On-Time** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L19 |
| **Total** | | | **100** | | ||

