# Assignment 3 - Control Flow
**Name:**
<br>
<br>
**Section:**
<br>
<br>
**Documentation:**
<br>
<br>

## The Program

**(20pts)** Write a program that reads an **unsigned** word from `0x0216`.

- If the value is greater than `0x1234`: 
    - Use a loop to add `20+19+18+...+1` (decimal)
    - Store the result (as a word) in `0x0206`
    - Note: don't add `20+19+18+...+1` to `0x1234`, just sum the sequence by itself and store in memory.
- If the value is less than or equal to `0x1234`:
    - If the value is greater than `0x1000`:
        - Add `0xEEC0` to the value
        - Store the value of the carry flag (as a byte) in `0x0202`
    - If the value is less than or equal to `0x1000`:
        - If the value is even:
            - Divide the value by 2
        - If the value is odd:
            - Multiply the value by 2
        - Store the result (as a word) in `0x0212`
- Once you've accomplished the appropriate task, trap the CPU

**Extra credit goes to the student who creates the shortest program.  My solution is 20 instructions long.**

## Questions

<ol start="1">
<li> **(10pts each)** Run the following starting values through your program and record the results.  Be sure to list the expected answer **(4 pts)**, the answer you received **(3 pts)**, and address that answer was written to **(3 pts)**.

a) `0x1235`:
<br>
<br>
<br>
<br>
b) `0x1234`:
<br>
<br>
<br>
<br>
c) `0x1001`:
<br>
<br>
<br>
<br>
d) `0x0800`:
<br>
<br>
<br>
<br>
e) `0x801`:
<br>
<br>
<br>
<br>

<ol start="2">
<li> **(20pts)** In the MSP430G2553 detailed Tech Doc (using PDF with **bookmarks** recommended): <br>
a) (5pts) What is the range of **recommended operating** voltages for the MSP430G2553? <br> <br> <br> <br>
b) (5pts) What are the **absolute maximum** and minimum voltages that should be applied to any pin? <br> <br> <br> <br>
c) (10pts) Interpreting **Electrical Characteristics**.  Running at 3.5 V, what is the operating current of the MSP430G2553 at <br>
i)	Fdco = 16 MHz <br> <br>
ii)	 Fdco = 12 MHz <br> <br>
iii)  Fdco = 8 MHz <br> <br> 
iv)	 Fdco = 1 MHz <br> <br>
<br>	
<ol start="3">
<li> **(10 pts)** For the following question consult page 25.<br>
a) Assume your MSP430 is operating at room temperature and 3 V supply.  You need to draw a large amount of current from an MSP430 I/O pin while not allowing the output voltage to fall below Vcc = 2.5 V at high-level output voltage and rise above Vss = 0.5 V at low-level output voltage.  How much current can you draw from the I/O pin in each case? <br> <br> <br> <br> <br> <br>
b) Pin P1.0 can be functionally multiplexed between an I/O signal and an analog-to-digital converter (ADC) signal (represented by AX, where X is the pin number).  In order to select the proper multiplexed signal, one must ensure certain bits are set or cleared in certain registers.  Describe what values need to be written to P1DIR, P1SEL, and P1SEL2 in order to select a) digital output and b) ADC input for P1.0.  Hint, consult page 43. <br> <br> <br> <br> <br> <br> <br> <br>

## Turn-in Requirements

- Submit your final working assembly program on Bitbucket.
- Turn in answers to the above questions.
