;-------------------------------------------------------------------------------
; Lesson 14 - Polling. Debouncing. Software Delay Routines.
;
; Purpose:  Counts button pushes on P1.3.  Count stored in R4
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

			  ; Set up active-low button for input
              bis.b  #BIT3, &P1OUT
              bis.b  #BIT3, &P1REN
              bic.b  #BIT3, &P1DIR

              clr    R4			; track number Btn pushes

check_btn:    bit.b  #BIT3, &P1IN
              jz     btn_pushed
              jmp    check_btn

btn_pushed:   inc    R4

wait:         bit.b  #BIT3, &P1IN	; wait until button release
              jz     wait

              jmp    check_btn

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

