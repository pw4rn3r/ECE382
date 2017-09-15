title = 'Lab 2 - Subroutines - "Cryptography"'

# Lab 2 - Subroutines - "Cryptography"

## Objectives

You'll practice your programming skills by writing some subroutines.  You'll need to use both the call-by-value and call-by-reference techniques to pass arguments to your subroutines.

## Details

### The Basic Idea

You'll write a program that decrypts an encrypted message using a simple encryption technique.  To achieve A-level functionality, you'll have to decrypt a message without knowledge of its key.

A simple, yet effective encryption technique is to `XOR` a piece of information with a key and send the result.  The receiver must have the key in order to decrypt the message - which is accomplished simply by `XOR`ing the encrypted data with the key.  Let's say I wanted to send the binary byte `0b01100011` and my key was `0b11001010`.  To encrypt, I `XOR` the two - the resulting byte is `0b10101001`.  To decrypt, I `XOR` it with the key again - the resulting byte is `0b01100011` - the same as the original byte!

An encrypted message of arbitrary length is stored in ROM.  Your job is to decrypt it, given a key - which is also stored in ROM.  The contents of the message are [ASCII characters](http://en.wikipedia.org/wiki/ASCII) - each character is encoded in a single byte.  You can tell how long the message is by counting the number of bytes or by finding the difference between the address of the last byte and the address of the first byte.

**You must write two subroutines:**

- **decryptByte**:  The job of the first subroutine is to decrypt an individual piece of information.  It should use the pass-by-value technique to take in an encrypted byte and a key byte.  The decrypted byte is then returned.
- **decryptMessage**:  The job of the second subroutine is to leverage the first subroutine to decrypt the entire message.  It should use the pass-by-reference technique to take in the address of the beginning of the message, the address of the key, and the address in RAM where the decrypted message will be placed.  It should use the pass-by-value technique to take in the length of the message (and length of key for B functionality).  It will pass the encrypted message byte-by-byte to the first subroutine, then store the decrypted results in RAM.

Almost all of the work of your program will be performed in your two subroutines.  Your main program should look something like this:
```
;initialize stack
;disable watchdog

;load addresses into registers to pass to decrypt_message subroutine

call        #decrypt_message

CPUtrap:     jmp     CPUtrap
```

[I have given you a template to get you started on Required Functionality.](template.html)

Sometimes the key isn't conveniently the same length as the unit of information you're trying to decrypt.  To achieve B functionality, you'll have to adjust your implementation to handle arbitrary length keys.

**Be sure to maintain good program structure and programming discipline when adjusting your program for B Functionality.**

To achieve unbreakable encryption, the key and the message must be the same length.  For long messages, this is often impractical and a key substantially shorter than the message is used.  Thus, the key must be applied repeatedly to decrypt the message.  You can exploit this repetition to crack the message.  This is even easier if you have knowledge of the contents of the message (ASCII text, for instance).  To achieve A Functionality, you'll have to use this technique to decrypt a message without knowledge of the key.

### Required Functionality

- The encrypted and decrypted message will be in memory locations.  The encrypted message and key will be stored in ROM - any location in ROM is acceptable.  The message will be of arbitrary length, but the key will be one byte long.  The decrypted message will be stored in RAM starting at 0x0200.  Labels shall be used to to refer to the location of the encrypted message, decrypted message, and key.
- The key and encrypted message will be given to you.  You can tell how long the message is by counting the bytes or by finding the difference between the address of the last byte and the address of the first byte.
- Good coding standards, in accordance with the [Lab guidelines](/382/admin/labs.html), should be used throughout.

Encrypted Message:
```
0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9,0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2,0xcd,0xc0,0xc5,0xd8,0xd5,0x8f
```

Key: `0xac`


### B Functionality

In addition to the Required Functionality, your program must decrypt messages with arbitrarily long keys.  The keys are arbitrarily long series of bytes.

The length of the key should be a parameter passed into your `decryptMessage` subroutine.  **You know the length of the key in advance.**  Also, you should not have to change your `decryptByte` subroutine!


Encrypted Message:
```
0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac,0x42,0xcb,0xba,0x03,0xc7,0xba,0x5a,0x8c,0xb3,0x46,0xc2,0xb8,0x57,0xc4,0xff,0x4a,0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab,0x50,0x82,0xff,0x03,0xe5,0xab,0x03,0xc3,0xb1,0x4f,0xd5,0xff,0x40,0xc3,0xb1,0x57,0xcd,0xb6,0x4d,0xdf,0xff,0x4f,0xc9,0xab,0x57,0xc9,0xad,0x50,0x80,0xff,0x53,0xc9,0xad,0x4a,0xc3,0xbb,0x50,0x80,0xff,0x42,0xc2,0xbb,0x03,0xdf,0xaf,0x42,0xcf,0xba,0x50
```

Key: `0xacdf23`

Successfully decrypting this message will give you useful information to achieve A Functionality.


### A Functionality

In addition to B Functionality, you must decrypt the following message *without* knowledge of its key (to include its length!):

```
0x35,0xdf,0x00,0xca,0x5d,0x9e,0x3d,0xdb,0x12,0xca,0x5d,0x9e,0x32,0xc8,0x16,0xcc,0x12,0xd9,0x16,0x90,0x53,0xf8,0x01,0xd7,0x16,0xd0,0x17,0xd2,0x0a,0x90,0x53,0xf9,0x1c,0xd1,0x17,0x90,0x53,0xf9,0x1c,0xd1,0x17,0x9e
```

**Again, your program must find the key and decrypt the message, specifically in one glorious run.** There are many ways to attack this problem.  Some techniques require substantially more CPU time than others.  Some techniques can be done by hand.  Take the time to think through your approach before you begin coding.


## Prelab

**Remember, the Prelab is due one full business day prior to the lab in order to provide your instructor time to provide you feedback on your plan (before you start implementing it).** 

#### Prelab Deliverables
1. Flowchart and/or pseudocode for *each* subroutine
    - Plan for at least B functionality from beginning
    - If you have a solid plan for A functionality, then include separate flowcharts and/or psuedocode, etc as needed.
2. Provide interfaces for your subroutines.  A listing or table of input and output registers, along with their purpose is sufficient.  Make sure it is clear which registers hold pointers.
3. How will you test your code?  *Read the Notes section for a hint*.
4. Identify and limitations of your proposed implementation. 
5. Is there anything about this lab that you would like me to address at the beginning of class?

Include in your prelab any other information, if any, from this lab you think will be useful in creating your program.


## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/382/admin/labs.html) thoroughly and follow it.

If you want, decrypt the first word of the message by hand so you get the idea of how it works.  If the ASCII characters you are getting do not make sense, you are probably thinking about the problem incorrectly.

The MCU is fast - your program should execute almost instantaneously.  Set a breakpoint at the point in your code where you trap the CPU - if it isn't hit quickly, you've got a problem.

In CCS, it's possible to view memory as Characters - this will be helpful in determining whether you successfully decrypted a message.

Since decryption and encryption are the same operation, you can encrypt test messages using the same subroutines you'll use to decrypt them.  **This would be a great way to test functionality of your code.**

Use assembler directives for placing strings / byte sequences in memory:
```
stringLabel     .string     "This is a string!"
byteLabel       .byte       0xab,0xcd,0xef
```

## Grading - Lab 2

#### Proof of functionality
Rather than documenting proof of functionality, in this lab **you will be performing a live demo** to prove that your code works.  Videos may be accepted at instructor discretion.

If the instructor who verifies your demo does not teach your section, it is recommended that you print and provide a copy of the [Printable Lab 2 Cutsheet](Lab_2_Cutsheet.pdf) to the instructor evaluating your code functionality.  Provide this cutsheet to your instructor when the lab is due.

#### Final report requirements
The final report will be very limited in scope.  Simply document any changes to your design, limitations, and test plan since the Prelab.  This is especially important for A functionality.  **If there are no changes, however, simply state that fact.**  Note, any broken functionality is considered a limitation.

You do not need to include any other sections in your final report.



**Name:**<br>
<br>
**Section:**
<br>
<br>
**Documentation:**<br>
<br>

**Lab 2 Grade Sheet**

**Name:**

**Section:**

| **Item**                    | **Grade**                                                           | **Points** | **Out of** | **Date** | **Due**               |
|-----------------------------|---------------------------------------------------------------------|------------|------------|----------|-----------------------|
| **Prelab**                  | **On-Time:** ---- **Late:**  1Day ---- 2Days ---- 3Days ---- 4+Days |            | 25         |          | Bus. Day Prior to L11 |
| **Required Functionality**  | **On-Time:** ---- **Late:**  1Day ---- 2Days ---- 3Days ---- 4+Days |            | 35         |          | L13                   |
| **B Functionality**         | **On-Time:** ---- **Late:**  1Day ---- 2Days ---- 3Days ---- 4+Days |            | 20         |          | L13                   |
| **A Functionality (Bonus)** | **On-Time:** ---- **Late:**  1Day ---- 2Days ---- 3Days ---- 4+Days |            | 10         |          | L13                   |
| **Code**                    | **On-Time:** ---- **Late:**  1Day ---- 2Days ---- 3Days ---- 4+Days |            | 10         |          | L13 Taps              |
| **Lab Notebook**            | **On-Time:** ---- **Late:**  1Day ---- 2Days ---- 3Days ---- 4+Days |            | 10         |          | L13 Taps              |
| **Total**                   |                                                                     |            | **110**    |          |                       |
