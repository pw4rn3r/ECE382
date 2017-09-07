;-------------------------------------------------------------------------------
; Assignment 4 - Stack Homework
;
; This program demonstrates the Stack operation in the MSP430.
;
; Is this program (particularly the stackmanip subroutine) written using good 
; coding practices?
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
                                            ; make it known to linker.
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------

; Fill memory with 0xBEEF or some known values before running this.
; That way you can easily see which addresses have data that does not change.

main:
        mov.w   #0xDFEC, r10
        mov.w   #0x3415, r11
        mov.w   #0x2006, r6
        mov.w   #0xCAFE, r12
        call    #stackmanip
        nop

forever:
        jmp     forever

stackmanip:
        push.w  r12
        push.w  r11
        mov.w   r6, -8(SP)
        add     r10, r6
        push.b  r6
        mov.w   r12, r11
        pop     r10
        pop.b   r6
        pop     r11
        pop     r12
        ret




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
