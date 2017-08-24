;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
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

;-------------------------------------------------------------------------------
; Overflow Bit
;-------------------------------------------------------------------------------

	mov.w   #0x7fff, r5
	add.w   #1, r5          ; sets N, V

	mov.b   #0x80, r5       ; note how MOV doesn't impact flags.  BIC, BIS don't either.
	add.b   #0x80, r5       ; sets C, V, Z - resets N

	mov.b   #0x7f, r5
	sub.b   #0x80, r5       ; sets N - resets Z, C

;-------------------------------------------------------------------------------
; Negative Bit
;-------------------------------------------------------------------------------

	mov.w   #0x8001, r5
	cmp.w   #0x1, r5        ; sets N, C

	cmp.w   #0x1000, r5     ; sets C, V - resets N
	add.w   #00001111b, r5  ; sets N - resets C, V

;-------------------------------------------------------------------------------
; Zero Bit
;-------------------------------------------------------------------------------

	mov.w   #10, r5
	cmp.w   #10, r5         ; sets C, Z
	                        ; note how CMP only sets flags, along with BIT, TST

	sub.w   #10, r5         ; sets C, Z
	tst     r5              ; sets C, Z
							; talk about how tst emulated CMP #0, dst

;-------------------------------------------------------------------------------
; Carry Bit
;-------------------------------------------------------------------------------

	mov.w   #1, r7
    add.w   #0xffff, r7

    mov.w   #1, r7
    add.w   #0x7fff, r7

    mov.w   #0xffff, r7
    add.w   #0xffff, r7

    xor.w   #10101010b, r7

;-------------------------------------------------------------------------------
; Example of some Emulated Instructions
;-------------------------------------------------------------------------------

    clrc
    clrn
    setz

;-------------------------------------------------------------------------------
;
;-------------------------------------------------------------------------------

    ; example of a conditional
    mov     #10, r7
    cmp     #5, r7              ; set C - why is the carry flag set here?  think about how CMP is SUB and how the SUB operation is implemented
    jge     greater             ; if N == V, jump
    mov     #0xbeef, r7
    jmp     done                ; always jump
greater:
    mov     #0xdfec, r7
done:
    ; example of a loop
    mov     #0, r6
    mov     #10, r7
loop:                           ; count upward by 2 ten times
    add     #2, r6
    dec     r7
    jnz     loop

forever:                        ; trap CPU
    jmp     forever

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
            
