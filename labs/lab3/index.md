
title = 'Lab 3 - SPI - "I/O"'

# Lab 3 - SPI - "I/O"

## Given code
- [color.h](color.h) - lists some of the colors at your disposal on the LCD
- [lab3_given.asm](lab3_given.asm)

## Supplemental Slides
 - [ECE382_Lab3-Help.pptx](ECE382_Lab3-Help.pptx) - Describes timing, how pixels are written, and how colors are represented

##  Mega Prelab
A hard copy of this Mega Prelab is required to be turned in as well as pushed to Bitbucket.  Answers should not be handwritten.  The timing diagram may be NEATLY drawn by hand with the assistance of a straightedge on engineering paper.

### Delay Subroutine
In lab3_given.asm, you have the header for a subroutine (line 579), but there is no code.  Write a subroutine that will create a 160ms delay.  Show your analysis that proves the delay is indeed very close to 160 ms.  Note: the clock rate is set to 8 MHz (see the first two lines of initMSP).

### ILI9341 LCD BoosterPack 

Look at the schematic for the LCD BoosterPack. Complete the following table.  The pin number (1 - 20) should be the pin number that signal connects to on the MSP 430, and the PX.X should be the pin and port it connects to (e.g. P1.0). <br>

| Name | Pin # | PX.X|
|:-: | :-: |:-: |
| S1 |   |   |
| S2 |   |   |
| S3 |   |   |
| S4 |	| |
| S5 |	| |
| MOSI| | | 
| CS | | |
| DC | | |
| MISO| | ||

What are the hex values that need to be combined with the below registers for these signals to be properly configured?  State whether that hex value needs to be used with the bis or bic instruction with each register to achieve these ends.  If the register is not affected for that signal, simply say N/A. 

|Signal|PxDIR|PxREN|PxOUT|PxSEL|PxSEL2|
|:-:|:-:|:-:|:-:|:-:|:-:|
|S1| | | | ||
|MOSI||||||
|CS| | | | |||



### Configure the MSP430

Look at the initMSP subroutine in the lab3_given.asm file.  There are four pins being intialized on port 1: SCLK, CS, MOSI, and DC.  What is the pin number (1-20) associated with each of these signals?  What function does each signal serve?  For example, SCLK is the serial clock. 

| Name | Pin # | Function |
|:-:|:-:|:-:|
| SCLK |   | serial clock  |
| CS |   |   |
| MOSI |   |   |
| DC |	| | |

Below the pin configuration code are some lines of code from the lab3_given.asm file (lines 136 - 143) to properly configure the SPI subsystem.  Use this code to answer the next two questions.
```
1:		bis.b	#UCSWRST, &UCB0CTL1
2:		mov 	#UCCKPH|UCMSB|UCMST|UCSYNC, &UCB0CTL0
3:		bis 	#UCSSEL_2, &UCB0CTL1
4:		bis 	#BIT0, &UCB0BR0
5:		clr	&UCB0BR1
6:		bis	#LCD_SCLK_PIN|LCD_MOSI_PIN|LCD_MISO_PIN, &P1SEL
7:		bis	#LCD_SCLK_PIN|LCD_MOSI_PIN|LCD_MISO_PIN, &P1SEL2
8:		bic	#UCSWRST, &UCB0CTL1
```
Fill in the chart below with the function that is enabled by the lines 6&7 of the above code.  Your device-specific datasheet can help.

| Pin name | Function | 
|:-:|:-:|
| P1.5| |
| P1.7| |
| P1.6| ||

Next, describe specifically what happens in each of the eight lines of code above.  Line 1 and 3 have been done for you as an example. <br>

Line 1: Setting the UCSWRST bit in the CTL1 register resets the subsystem into a known state until it is cleared. <br>
Line 2: <br>
Line 3: The UCSSEL_2 setting for the UCB0CTL1 register has been chosen, selecting the SMCLK (sub-main clock) as the bit rate source clock for when the MSP 430 is in master mode. <br>
Line 4: <br>
Line 5: <br>
Line 6: <br>
Line 7: <br>
Line 8: <br>

### Communicate with the LCD
The following code (lines 297 - 338) sends one byte (either data or command) to the TM022HDH26 display using its 8-bit protocol.  

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
The following code (lines 552 - 576) draws a pixel of a predetermined color at the coordinate (R12, R13).  However, four subroutines are called to execute this seemingly simple task.  Explain the purpose of each of the four subroutine calls:

|Subroutine| Purpose|
|:-:|:-:|
|setArea| |
|splitColor| |
|writeData| |
|writeData| ||

```
;-------------------------------------------------------------------------------
;	Name: drawPixel
;	Inputs: x in r12, y in r13, where (x, y) is the pixel coordinate
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
The answers to the logic analyzer section will be posted to Bitbucket in the lab writeup.
###Physical communication
Connect the LCD Booster Pack to your TI Launch Pad.  Make sure that the buttons on the Booster Pack are aligned with the buttons on the MSP430.  The pin numbers on the Boosterpack should match the pin numbers of the MSP430.
<br>
Create a project around the lab3_given.asm file.  Be sure to include your Delay160ms subroutine.

After you insert your subroutine into the code, run the program and observe the output on the LCD every time you press the S1 button.  
<br>
When S1 is detected as being pressed and released (lines 103 - 105), the drawLine subroutine is called.  The MSP430 generates several packets of data that are sent to the LCD, causing a horizontal bar to be drawn. **Find the three calls to writeCommand and eight calls to writeData that generate these packets.** In addition, scan the nearby code to determine the parameters being passed into these subroutines. 

Configure the logic analyzer to capture the waveform generated when the S1 button is pressed and released. Decode the data bits of each 8-bit waveform.  Explain how the packet contents correspond to what was drawn on the display.  Be specific with the relationship between the values sent and what and where the pixels are drawn. Is the packet of information being sent actual data or is it a command?  The "Line" column refers to the line of code from which the call to write something to the LCD originated.

|Packet|Line|Command/Data|8-bit packet|Meaning of packet|
|:-:|:-:|:-:|:-:|
|1|||||
|2|||||
|3|||||
|4|||||
|5|||||
|6|||||
|7|||||
|8|||||
|9|||||
|10|||||
|11||||||

Be sure to label your signals on the logic analyzer and include screenshots (which can be saved to your external hard drive, for eventual posting in your lab notebook) of each analyzed signal.


## Functionality

**All functionality must be demonstrated live to an instructor.**  You do not need to include pictures or videos of functionality in your report.


### Required functionality: 
Create a block on the LCD that is 10x10 pixels.  <br>
### A functionality: 
Move the 10-pixel block one block (10 pixels) in the direction of the pressed button (up, down, left, right).  
### Bonus functionality: 
Write your name or nickname of at least 5 characters to the screen on a solid background when the S1 button is pushed.


## Grading - Lab 3
[Printable Lab 3 Cutsheet](Lab_3_Cutsheet.pdf)

**Name:**<br>
<br>
**Section:**
<br>
<br>
**Documentation:**<br>
<br>

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Mega Prelab | **On-Time:** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days | | 20 | | BOC L16 |
| Required Logic Analyzer | **On-Time:** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 40 | | COB L19 |
| Required Functionality | **On-Time:** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 20 | | COB L19 |
| A Functionality | **On-Time:** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L19 |
| Bonus Functionality | **On-Time:** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 5 | | COB L19 |
| Lab Notebook | **On-Time:** -------------------------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L19 |
| **Total** | | | **100** | | | |


## Lab 3 Deliverables

#### Functionality (30 + 5 bonus pts) - *Demonstrated* NLT COB Lesson 19

**Required (20 pts)**

-   10 x 10 box is shown on LCD screen with no other artifacts (painted pixels)
    shown

**A Functionality (10 pts)**

-   10 x 10 box moves UP, DOWN, LEFT, RIGHT by 10 pixels upon each corresponding
    button press

-   Box shall not leave artifacts on screen as you move it

-   Box should move *quickly.*

    -   Do NOT clear the entire screen during a move. Clear only the box.

    -   Make sure you are only painting the pixels required for the box.

    -   setArea should be used with the box dimensions. Do not setArea to one
        pixel.

-   Box should move across *entire* screen to within 10 pixels of edges

    -   No requirement to do anything specific once edge is reached

**Bonus Functionality (5 pts)**

-   Upon pressing the S1 button, your name or nickname of at least 5 characters
    is shown on the LCD screen on a solid background.


#### Required Logic Analyzer (40 pts) – Due NLT TAPS Lesson 19

1.  **(3 pts) Brief overview** of what is going on in setArea (pictures help!)

2.  **(5 pts) Overview screenshot** from logic analyzer with 11 setArea packets
    you captured clearly identified
 
    1.  Include all signal labels (SCLK, CS, DC, MOSI)

    2.  Placing label at position when CS goes low is fine

3.  **(20 pts) Table** of 11 setArea packets captured

    1.  Using hex to represent 8-bit packet values preferred

4.  **(5 pts ea) Two packet screenshots** from logic analyzer

    1.  One **command** packet example and one **data** packet example

    2.  Include all signal labels (SCLK, CS, DC, MOSI)

    3.  Label the data with its value

5.  **(2 pts) Brief analysis**

    1.  Why do the values (SC, EC, command bytes, etc) that you captured make
        sense?


#### Lab Notebook (10 pts) – Due NLT TAPS Lesson 19

1.  Title and Author

2.  *Corrected* Prelab

3.  Screenshot of *measured* 160ms (within 1 ms) delay from logic analyzer

    1.  Include any necessary explanation. How does it compare to your
        calculated results? What is your actual clock frequency (not 8 MHz)?

4.  Logic Analyzer section – setArea capture and explanation (see above)


#### Code

- **While no points are associated with code this lab, you should still push it
with your other lab files.**

