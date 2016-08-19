```
    mov.w   #0x7fff, r5
    add.w   #1, r5

    mov.b   #0x80, r5       ; note how MOV doesn't impact flags.  BIC, BIS don't either.
    add.b   #0x80, r5

    mov.b   #0x7f, r5
    sub.b   #0x80, r5


    mov.w   #0x8001, r5
    cmp.w   #0x1, r5

    cmp.w   #0x1000, r5
    add.w   #00001111b, r5


    mov.w   #10, r5
    cmp.w   #10, r5         ; note how CMP only sets flags, along with BIT, TST

    sub.w   #10, r5
    tst     r5              ; talk about how tst emulated CMP #0, dst


    mov.w   #1, r7          
    add.w   #0xffff, r7     

    mov.w   #1, r7
    add.w   #0x7fff, r7     

    mov.w   #0xffff, r7
    add.w   #0xffff, r7     

    xor.w   #10101010b, r7 


    clrc
    clrn
    setz

    ; example of a conditional
    mov     #10, r7
    cmp     #5, r7              ; why is the carry flag set here?  think about how CMP is SUB and how the SUB operation is implemented
    jge     greater
    mov     #0xbeef, r7
    jmp     done
greater:
    mov     #0xdfec, r7
done:
    ; example of a loop
    mov     #0, r6
    mov     #10, r7
loop:
    add     #2, r6
    dec     r7
    jnz     loop



;-------------------------------------------------------------------------------
;	Name:		Capt Jeff Falkinburg
;	Term:		Fall 2016
;	MCU:		MSP430G2553
;	Lecture:	4
;	Date:		19 August 2016
;	Note:		Variety of assembly instructions
;-------------------------------------------------------------------------------
	.cdecls C,LIST,"msp430.h"	; BOILERPLATE	Include device header file
;-------------------------------------------------------------------------------
	.def    RESET               ; Export program entry-point to
                                ; make it known to linker.
;-------------------------------------------------------------------------------
 	.text			; BOILERPLATE	Assemble into program memory
	.retain			; BOILERPLATE	Override ELF conditional linking and	.retainrefs		; BOILERPLATE	Retain any sections that have
	.global main		; BOILERPLATE	Project -> Properties and
				;			select the following in the pop-up
				; Build -> Linker -> Advanced -> Symbol Management
				;    enter main into the Specify program entry point... text box

op1:	.byte	0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F
op2:	.byte	0x00,0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80,0x90,0xA0,0xB0,0xC0,0xD0,0xE0,0xF0

;-------------------------------------------------------------------------------
;           			main
;-------------------------------------------------------------------------------
main
RESET	mov.w   #__STACK_END,SP		; BOILERPLATE	Initialize stack pointer
StopWDT	mov.w   #WDTPW|WDTHOLD,&WDTCTL 	; BOILERPLATE	Stop watchdog timer

;------------------------------------------------------------------------
; XOR SWAP algorithm = swap two variables without using a third
;------------------------------------------------------------------------

	mov.w	#0x1234, R5		; Move a constant into the memory location
	mov.w	#0xABCD, R6
	xor.w	R5, R6			; complete the first XOR
	xor.w	R6, R5			; complete the first XOR
	xor.w	R5, R6			; complete the first XOR

;------------------------------------------------------------------------
; bit manipulations
;------------------------------------------------------------------------
	mov.w	#0xCCCC, R7
	bic.w	#0x00FF, R7		; clear all the bits in the lower byte
	bis.w	#0xFF00, R7		; set alll the bits in the upper byte
	xor.w	#0x0FF0, R7		; toggle "middle" byte

;------------------------------------------------------------------------
; This will create a loop that iterates 8 times.  Assembly loops
; are general count-down; the DEC instruction makes this
; the more natural construct in the MSP assembly.
;------------------------------------------------------------------------
	clr.w	R5			; we'll use this to count the number of loop iterations
	mov.w	#0x08, R6		; we want exactly 8 iterations of the loop's body
loop
	inc.w	R5			; This is the body of this loop - pretty dimutitive
	dec.w	R6			; decrement the loop counter
	jnz	loop


;------------------------------------------------------------------------
; if (R5 > R6) then R7 = 7 else R7 = 0
;------------------------------------------------------------------------
	mov.w	#0x05, R5		; load up a pair of test values in the registers.
	mov.w	#0x06, R6		; three cases that will be checked in class
	cmp	R5, R6			; computes R6-R5, does not change either reigster
	JL	setR7			; if (R6 less than R5) goto setR7
clrR7
	mov.w	#0x00, R7
	jmp	nextCompare		; this is the label of the next example
setR7
	mov.w	#0x07, R7


;------------------------------------------------------------------------
; if (R8 <= R9) then R10 = 0x10 else R10 = 0
;------------------------------------------------------------------------
nextCompare
	mov.w	#0x08, R8		; load up two test values in the registers.
	mov.w	#0x09, R9		;
	cmp	R8, R9			; this computes R9-R8, setting status register flags
	jge	setR10			; if (R9 greater equal R8) goto setR10
clrR10
	mov.w	#0x00, R10
	jmp	arrayExample
setR10
	mov.w	#0x10, R10

;------------------------------------------------------------------------
;------------------------------------------------------------------------
arrayExample
	mov.w	#0x10, R5
	mov.w	#op1, R6
	mov.w	#op2, R7
	mov.w	#0x300, R8		; not a great practice, but we are pointing to RAM

sumLoop					; it’s a post-increment festival
	mov.b	@R6+, R9			; move op1 into R9
	add.b	@R7+, R9			; add op2 to R9
	mov.b	R9, 0(R8)		; store sum back into sum array
	inc.w	R8			; you can’t post increment a destination register, :(
	dec.w	R5			; decrement the loop counter
	jnz	sumLoop

done
	jmp	done			; just loop forever, or until you interrupt things



;-------------------------------------------------------------------------------
;           System Initialization
;-------------------------------------------------------------------------------
	.global __STACK_END		; BOILERPLATE
	.sect 	.stack			; BOILERPLATE
	.sect   ".reset"			; BOILERPLATE		MSP430 RESET Vector
	.short  main			; BOILERPLATE







```
