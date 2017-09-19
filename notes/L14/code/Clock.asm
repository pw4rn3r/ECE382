;-------------------------------------------------------------------------------
; Lesson 14 - Polling. Debouncing. Software Delay Routines.
;
; Purpose: Expose SMCLK on P1.4 for capture on logic analyzer
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
			bis.b #BIT4, &P1DIR ; show SMCLK on P1.4
			bis.b #BIT4, &P1SEL
;			bis.b #DCO2|DCO1|DCO0, &DCOCTL ; drive clock at fastest possible settings
;			bis.b #RSEL3|RSEL2|RSEL1|RSEL0, &BCSCTL1
forever 	jmp forever
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
