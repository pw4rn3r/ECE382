repeat:
    mov.b     #0x75, r10
    add.b     #0xC7, r10
    ;result should be 0x13c, so we should see 3c in r10 and carry bit set
    
    adc     r10 ;since carry bit was set, this should increment r10 to 3d
    
    inv.b     r10 ;invert, so r10 should be c2
    
    mov.w   #0x00aa, r10
    sxt     r10 ;sign extend should clear upper 8 bits
    
    inv     r10 
    swpb    r10
    mov.w   r10, r9

    jmp     repeat
