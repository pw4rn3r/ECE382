;-------------------------------------------------------------------------------
; Lesson 14 - Polling. Debouncing. Software Delay Routines.
; Capt Jeff Falkinburg, USAF / 19 Sep 2016 / 19 Sep 2016
;
; Purpose:  Program instantiates a software delay subroutine to debounce the button
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

					 ; Setup P1.3 for button input
                     bis.b  #BIT3, &P1OUT
                     bis.b  #BIT3, &P1REN
                     bic.b  #BIT3, &P1DIR

                     clr R4			; BtnCounter

; Increment Btn Counter on Btn press
; A delay is used immediately after the press and release
check_btn:           bit.b  #BIT3, &P1IN
                     jnz    check_btn

                     inc R4

                     call   #software_delay
                     jmp    btn_pushed

btn_pushed:          bit.b  #BIT3, &P1IN
                     jz     btn_pushed

                     ; Btn released
                     call   #software_delay
                     jmp    check_btn


; -------------------------------------------
; Software delay
; Purpose:  Delays code based on value of R5
;			R5 is currently hard coded as 0xAAAA
; -------------------------------------------
software_delay:
					push r5
					mov.w #0xaaaa, r5

delay:				dec r5
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
