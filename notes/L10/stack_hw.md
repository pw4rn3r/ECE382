# Assignment 4 - Stack Homework
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

Given the below code and a stack pointer initialized to 0x0400, fill in the contents of the stack and the registers after the execution of the command at address `0xC020`. You should be able to complete this exercise without the use of Code Composer Studio, but you are welcome to check your answers with the program.
```
Address:	  Program:
-----------------------------------
			  main:
0xC00A		mov.w   #0xDFEC, r10	
0xC00E		mov.w   #0x3415, r11	
0xC012		mov.w   #0x2006, r6	
0xC016		mov.w   #0xCAFE, r12	
0xC01C		call    #stackmanip	
0xC01E		nop	
			  forever:	
0xC020		jmp     forever	
			  stackmanip:	
0xC022		push.w  r12	
0xC024		push.w  r11	
0xC026		mov.w   r6, -8(SP)	
0xC02A		add     r10, r6	
0xC02C		push.b  r6	
0xC02E		mov.w   r12, r11	
0xC030		pop     r10	
0xC032		pop.b   r6	
0xC034		pop     r11	
0xC036		pop     r12	
0xC038		ret	
```
<br>
------
<br>

|Address	| Initial Stack Value | New Stack Value (4 pts each) |
| :---: | :---: | :---: |
|0x03F0	|0xEF | |
|0x03F1	|0xBE | |
|0x03F2	|0xEF | |
|0x03F3	|0xBE | |
|0x03F4	|0xEF | |
|0x03F5	|0xBE | |
|0x03F6	|0xEF | |
|0x03F7	|0xBE | |
|0x03F8	|0xEF | |
|0x03F9	|0xBE | |
|0x03FA	|0xEF | |
|0x03FB	|0xBE | |
|0x03FC	|0xEF | |
|0x03FD	|0xBE | |
|0x03FE	|0xEF | |
|0x03FF	|0xBE | |
|0x0400	|0xEF | | |

<br>
**(5 pts) r6=** &#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f; 
<br>
<br>
**(5 pts) r10=** &#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f; 
<br>
<br>
**(5 pts) r11=** &#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f; 
<br>
<br>
**(5 pts) r12=** &#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f;&#x5f; 
<br>
<br>
**(12 pts)** Has the stackmanip subroutine been created using good coding practices?? Why or why not?
<br>
<br>
