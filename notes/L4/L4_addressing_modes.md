# L4 Assignment - Addressing Modes, Hand-assembly

## Addressing Modes

**Name:**
<br>
<br>
**Section:**
<br>
<br>
**Documentation:**
<br>
<br>

**All answers should be in little-endian, hex format.**

1. (10pts each) For each of the following instructions, identify the addressing modes being used.  For the indicated instructions, write the hand-assembled machine code that corresponds to that instruction.
```
swpb    r7
```
Addressing mode used for source:
<br>
<br>
<br>
Addressing mode used for destination:
<br>
<br>
<br>
hand-assembled machine code (**in little-endian, hex format**):
<br>
<br>
<br>
<br>
```
xor     @r12+, 0(r6)
```
Addressing modes used for Source:
<br>
<br>
<br>
Addressing mode used for destination:
<br>
<br>
<br>
hand-assembled machine code (**in little-endian, hex format**):
<br>
<br>
<br>
<br>
```
nop
```
Addressing mode used for source:
<br>
<br>
<br>
Addressing mode used for destination:
<br>
<br>
<br>
hand-assembled machine code (**in little-endian, hex format**):
<br>
<br>
<br>
<br>
```
mov.w   @r12, &0x0200
```
Addressing mode used for source:
<br>
<br>
<br>
Addressing mode used for destination:
<br>
<br>
<br>
hand-assembly of `mov @r12, r6`:
<br>
<br>
<br>
<br>
<ol start="2">
<li> (5pts) Consider the following code snippet:
```
            jmp     TARGET      ; address is 0xc000
...
TARGET:     nop                 ; address is 0xc024
```
What addressing mode do relative jumps use (if any)?
<br>
<br>
<br>
<br>
<br>
<br>
<br>

<ol start="3">
<li> (20pts) Consider the following code snippet:
```
mov.w   #0xFF, P1OUT    ;P1OUT is 0x0021
```
a) (5pts) What addressing modes are being used here?
<br>
<br>
<br>
Addressing mode used for source:
<br>
<br>
<br>
Addressing mode used for destination:
<br>
<br>
<br>

b) (10pts) The programmer wants this code to move 0xFF into P1OUT, but the code isn't working.  Why not?  
*Hint: talk about the assembly / linking process.*
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
c) (5pts) How would you change the code snippet to fix the problem?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</ol>

<ol start="4">
<li> (10pts) Consider the following code snippet:
```
mov.w   r10, @r9
```

a) (5pts) This doesn't assemble.  Why?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
b) (5pts) What's an equivalent replacement instruction?
<br>
<br>
<br>
<br>
<br>
<br>
<ol start="5">
<li> (5pts)What is the purpose of emulated instructions?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<ol start="6">
<li> (20pts)Use the MSP430x2xx Family User's Guide to answer the following questions:

a) (5pts) What status bits does the TST instruction manipulate?
<br>
<br>
<br>
<br>
<br>

b) (10pts) In the example code for the CMP instruction (page 77) what role do the R6 and R7 registers play?
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
c) (5pts) In the Digital I/O section, how is it recommended that you should configure unused pins?  In your own words, explain why is this course of action recommended.
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>