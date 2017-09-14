;-------------------------------------------------------------------------------
; ECE 382 Lesson 12 Quiz Code Fall, 2017
;
; Capt Phillip Warner
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

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

; setup register values
	mov #0xC100, r6
	mov #0x0F35, r10
	mov #0xAF22, r11
	mov #0xCAFE, r12

main:
        push.w r12
        call    #stackmanip
        nop

forever:
        jmp     forever

stackmanip:
        push.w  r11
        push.b  r10
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

; Initialize the stack with 6 words of 0xAAAA
; WARNING:  If you do not use an EVEN number of words, the initial SP value (STACK_END) will change to 0x03FE!
;			The values will fill from there, and a garbage word will be at 0x03FE-0x03FF.
;			The stack is filled with the words from RIGHT to LEFT.
FillStack:		.word   0xAAAA, 0xAAAA, 0xAAAA, 0xAAAA, 0xAAAA, 0xAAAA

; Example of how to initialize stack with 5 words of 0xBEEF
;FillStack:		.word   0xBEEF, 0xBEEF, 0xBEEF, 0xBEEF, 0xBEEF, 0xBEEF
;FillStack:		.byte	0xEF, 0xBE, 0xEF, 0xBE, 0xEF, 0xBE, 0xEF, 0xBE, 0xEF, 0xBE, 0xEF, 0xBE

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
