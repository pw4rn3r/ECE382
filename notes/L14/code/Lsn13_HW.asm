;-------------------------------------------------------------------------------
; Lesson 14 - Polling. Debouncing. Software Delay Routines.
; Capt Jeff Falkinburg, USAF / 19 Sep 2016 / 19 Sep 2016
;
; Purpose:  Modify Lesson 13 Code so the two LEDs always have the opposite value
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
			bis.b	#BIT0|BIT6, &P1DIR
			bic.b	#BIT3, &P1DIR
			bis.b	#BIT3, &P1REN
			bis.b	#BIT3, &P1OUT

check_btn:	bit.b	#BIT3, &P1IN
			jz		set_lights
;			bic.b	#BIT0|BIT6, &P1OUT
			bis.b	#BIT0, &P1OUT
			bic.b	#BIT6, &P1OUT
			jmp		check_btn
set_lights:	; bis.b	#BIT0|BIT6, &P1OUT
			bis.b	#BIT6, &P1OUT
			bic.b	#BIT0, &P1OUT
			jmp		check_btn

                                            

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
            
