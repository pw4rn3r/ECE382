; example program to add the numbers 10+9+8+...+1 and put result into 0x0200

			 mov.w       #10, r6
             mov.w       #0, r5

summation:   add.w       r6, r5
             dec         r6
             jnz         summation

             mov.w       r5, &0x0200

forever:     jmp         forever
