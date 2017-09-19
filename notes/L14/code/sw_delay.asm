;-------------------------------------------------------------------------------
; Lesson 14 - Polling. Debouncing. Software Delay Routines.
;
; Purpose:  Program instantiates a software delay subroutine to delay LED Blinking
;
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

;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
			bis.b #BIT0, &P1DIR

blinkLED:	bic.b #BIT0, &P1OUT
			call #software_delay
			bis.b #BIT0, &P1OUT
			call #software_delay
			jmp blinkLED


; -------------------------------------------
; Software delay
; Purpose:  Delays code based on value of R5
;			R5 is currently hard coded as 0xAAAA
; -------------------------------------------
software_delay:
			push r5
			mov.w #0xaaaa, r5

delay:		dec r5
			jnz delay
			pop r5
			ret
; End Software delay ---------------------------


;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
