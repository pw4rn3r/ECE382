# Lesson 10 - Subroutine and Stack Handout

```
;-------------------------------------------------------------------------------
;	Name:	Capt Jeff Falkinburg
;	Term:	Fall 2016
;	MCU:	MSP430G2553
;	Lecture:	Subroutines and the Stack
;	Date:	7 September 2016
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
num:	.byte	0x04

oper:	.byte	0x2A,0x14,0x0A,0x40
		.byte	0x11,0x22,0x5D,0x31
		.byte	0x4E,0x16,0x33,0x19
		.byte	0x2A,0x14,0x22,0x39

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer (must be first!)
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

main:
	mov.w	#num, R5				; put the address of num of 4-tuples in R5
	mov.b	@R5, R5					; read value at that address into R5
	mov.w	#oper, R6				; Point R6 to the first set of 4-tuples

loop:
	mov.b	@R6+, R12				; load up the call registers
	mov.b	@R6+, R13				; bump ptr R6 using the nice post inc
	mov.b	@R6+, R14
	mov.b	@R6+, R15
	call	#average				; don’t forget the “#” in front of label
	dec.b	R5						; decrement the loop counter
	jnz	loop

wait:								; terminate this process in an
	jmp	wait						; infinite loop


;-------------------------------------------------------------------------------
;	Name:		average
;	Inputs:	R12	first number to average
;			R13	second number to average
;			R14	third number to average
;			R15	forth number to average
;	Outputs:	R12	returned average
;	Purpose:	Compute the average of 4 integers
;-------------------------------------------------------------------------------
average:
	push	R5					;
	clr.w	R5					; clear sum of 4-tuple including upper byte for rra
	add.b	R12, R5
	add.b	R13, R5				; add together the values of the 4-tuple
	add.b	R14, R5
	add.b	R15, R5
	rra.w	R5					; arithmetic shift right?
	rra.w	R5

	mov.b	R5, R12				; store the value in the return register

	pop	R5						;
	ret							; the return pops the stac


Forever:	jmp Forever


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

```
