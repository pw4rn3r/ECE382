;-------------------------------------------------------------------------------
;	Author(s):	Capt Jeff Falkinburg, Capt Phillip Warner
;	Term:	Fall 2017
;	MCU:	MSP430G2553
;	Lecture:	Lsn 10 - Subroutines and the Stack
;	Purpose:  This program shows an example of using a subroutine to find the 
;			  average of four bytes
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.

NUM_ARRAYS:	.byte	0x04					; should match number of "numbers" rows below

ArraysLeft	.equ	R5

numbers:	.byte	0x2A,0x2A,0x2A,0x2A		; arrays of 4 numbers to find average of
			.byte	0x11,0x22,0x5D,0x31
			.byte	0x4E,0x16,0x33,0x19
			.byte	0x2A,0x14,0x22,0x39

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:

RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer (must be first!)
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

	mov.b	NUM_ARRAYS, ArraysLeft
	mov.w	#numbers, R6				; Point R6 to the first set of 4-tuples

AverageArrays:						; Loop to find NUM_ARRAYS averages
	mov.b	@R6+, R12				; load up the subroutine inputs
	mov.b	@R6+, R13				
	mov.b	@R6+, R14
	mov.b	@R6+, R15
	call	#average				; don’t forget the “#” in front of label
	
	dec.b	ArraysLeft
	jnz	AverageArrays

wait:						
	jmp	wait


;-------------------------------------------------------------------------------
;	Name:		average
;	Purpose:	Compute the unsigned average of 4 bytes
;	Inputs:		R12	first byte
;				R13	second byte
;				R14	third byte
;				R15	fourth byte
;	Outputs:	R12	returned average
;-------------------------------------------------------------------------------
average:
	push	R5					; Preserve R5
	clr.w	R5					; Note, you can write this function without using R5
								; We are simply providing an example of how to use an
								; additional register
	
	; add together the values of the 4-tuple
	add.w	R12, R5
	add.w	R13, R5
	add.w	R14, R5
	add.w	R15, R5
	
	; Divide by 4
	rra.w	R5					; Is RRA correct instruction?  What is highest possible sum?
	rra.w	R5

	mov.b	R5, R12				; store the average in the return register

	pop	R5						; restore R5
	ret							; the return address pops from the stack


UselessCPUtrap:
	jmp UselessCPUtrap			; should I ever get here during normal operation?


;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack

;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
