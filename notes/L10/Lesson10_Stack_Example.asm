;-------------------------------------------------------------------------------
;    Name:    Capt Jeff Falkinburg
;    Term:    Fall 2016
;    MCU:    MSP430G2553
;    Lecture:    Subroutines and the Stack
;    Date:    7 September 2016
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
; Main loop here
;-------------------------------------------------------------------------------

main:

RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer (must be first!)
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

		push.w      #0xdfec ;push the value 0xdfec onto the stack.
                            ;This decrements the SP by two to 0x03fe and
                            ; stores EC at 0x03fe and DF at 0x03ff
        pop.w       r10     ;pop the value we just pushed off of the stack and
                            ; into r10
                            ; this decrements the SP by two, back to 0x0400.
        push        #0xbeef
        push.b      #0xcc
        push        #0xdfec

        pop         r5
        pop.b       r6
        pop         r7

        push        #0xfade
        push.b      #0xaa
        push        #0xdeaf

        pop.b       r5
        pop         r6
        pop.b       r7

Forever:    jmp Forever


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
