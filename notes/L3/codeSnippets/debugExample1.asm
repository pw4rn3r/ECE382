main:
    bis.b   #0xFF, &P1DIR    ; set port1 direction to output
Turn_on:
    bis.b   #0xFF, &P1OUT    ; turn on leds at port1,  bis?
                             ; alternatively:    mov ____ , &P1OUT ???
Turn_off:
    bic.b   #0xFF, &P1OUT    ; turn on leds at port1,  bic?
                             ; alternatively:    mov ____ , &P1OUT ???
    jmp Turn_on              ; loop forever