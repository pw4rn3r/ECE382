;-------------------------------------------------------------------------------
;	Name:		Capt Jeff Falkinburg
;	Term:		Fall 2016
;	MCU:		MSP430G2553
;	Lecture:	5
;	Date:		25 August 2016
;	Note:		CCS exercise - this file has errors
;-------------------------------------------------------------------------------
	.cdecls C,LIST,"msp430.h"	; BOILERPLATE	Include device header file
;-------------------------------------------------------------------------------
	.def    RESET               ; Export program entry-point to
                                ; make it known to linker.
;-------------------------------------------------------------------------------
 	.text						; BOILERPLATE	Assemble into program memory
	.retain						; BOILERPLATE	Override ELF conditional linking and retain current section
	.retainrefs					; BOILERPLATE	Retain any sections that have references to current section
	.global main				; BOILERPLATE	Project -> Properties and select the following in the pop-up
								; Build -> Linker -> Advanced -> Symbol Management
								;    enter main into the Specify program entry point... text box

;-------------------------------------------------------------------------------
;           						main
;-------------------------------------------------------------------------------
main:
RESET 	mov.w   #__STACK_END,SP			; BOILERPLATE	Initialize stackpointer
StopWDT mov.w   #WDTPW|WDTHOLD,&WDTCTL 	; BOILERPLATE	Stop watchdog timer

	call	#initMSP
	mov.w	#0x20, &R5+				; R5 is the duty cycle

pwmLoop:
	mov.w	#0x40, R4				; initialize R4 with the period
	bis.w	#0x01, &P1OUT			; set P1 logic 1

pinHigh:
	dec.w	R4						; decrement the counter
	cmp.w	R5, R4					; until its less than
	jge		pinHigh					; the duty cycle

	bis.w	#0x01, &P1OUT			; set P1 logic 0

pinLo:
	dec.w	R4						; decrement counter
	cmp.w	#0, R4					; until its less than zero
	jl		pinLo					; portion of PWM cycle

	bit.w	#0x08, &P1IN			; check P1.3 - the button
	jnz		pwmLoop					; if button not pressed redo PWM

updatePWM:
	bit.b	#8, &P1IN				; bit 3 of P1IN being pressed?
	jz 		updatePWM				; Yes, branch back and wait


add.w	#0x04, R5				; decrease the duty cycle
	and.w	#0x3F, R5				; makre sure to clear any cout bits
	jmp		pwmLoop					; and do it again


;-------------------------------------------------------------------------------
;           initMSP
;	pin		dir			function
;	P1.0	out			red LED
;	P1.3	in			button
;-------------------------------------------------------------------------------
initMSP:

	bis.b	#8, &P1REN				; Pullup/Pulldown Resistor Enabled on P1.3
	bis.b	#8, &P1OUT				; Assert output to pull-ups pin P1.3

	bis.b	#1, &P1DIR 				; Set P1.0 as output (red LED)
	bic.b	#1, &P1OUT 				; Clear P1.1 - turn the LED off on start

	ret

;-------------------------------------------------------------------------------
;           System Initialization
;-------------------------------------------------------------------------------
	.global __STACK_END				; BOILERPLATE
	.sect 	.stack					; BOILERPLATE
	.sect   ".reset"				; BOILERPLATE		MSP430 RESET Vector
	.short  main					; BOILERPLATE
