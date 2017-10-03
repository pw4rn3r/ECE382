title = 'Compilers. Introduction to C.' 

# Lesson 19 Notes

## Readings
- Barrett A.1-A.4 (pp363-380)
- also Reference Digital Design and Comp Arch Book from ECE 281 
- [I'm a Compiler](http://stackoverflow.com/questions/2684364/why-arent-programs-written-in-assembly-more-often) - Read the question and top two answers, particularly the second answer
- [High-level Programming Language](http://en.wikipedia.org/wiki/High-level_programming_language)
- [PPT Slides](Lsn19.pptx)

## Assignment
- [Assignment 6 - C Basics](L19_C_basics.html)

## C Header Template
- [main_template.c](/382/admin/main_template.c)

## Lesson Outline
- Compilers
- Introduction to C

## Introduction

At this point in the course we have learned about the MSP430 and its instruction set.  We've learned some assembly programming constructs and implemented a few programs.  We've learned about some of the subsystems on our chip and used SPI.

But most engineers and developers don't program in assembly.

## Compilers

Let's talk about **compilers**.  Everyone do the reading?  If you haven't, you should - it's pretty entertaining and informative.

What are some other programming languages you know?  [List on board]

[List of Programming Languages](http://en.wikipedia.org/wiki/List_of_programming_languages)

The languages you listed are all what we call High Level Languages (HLL).

What are some benefits of using these over programming in assembly? 

- Ease of development
    - HLLs offer constructs that allow us to develop code faster.
        - loops
        - conditional statements (if/then)
        - functions
        - memory management (for some)
- Portability
    - HLL code can be made to run on many different machines, whereas assembly is architecture-specific
- Readability
    - HLL code is generally easier to read / understand than assembly
- Optimization
    - Humans typically aren't that great at writing assembly code
    - HLLs can offer optimization techniques / restrictions that can improve poorly-written code

*Some perspective*: everything that happens on a computer is machine code.  What do we use to generate machine code?  The assembler.  So every program you write ultimately becomes assembly code, then machine code.

*Remember our workflow*: **assembly code --> assembler --> relocatable machine code --> linker --> executable**

The compiler adds a layer on top of that.  It converts code written in a higher language into assembly, which can then be fed into the rest of our process:

**HLL --> compiler --> assembly code --> assembler --> relocatable machine code --> linker --> executable**

or, since we'll be compiling and assembling code for a different architecture than the one our computer is running, we'll be using a cross-compiler / cross-assembler:

**HLL --> cross-compiler --> assembly code --> cross-assembler --> relocatable machine code --> linker --> executable**

To further our understanding, let's break it down a little further - into Compiled and Interpreted languages.

Compiled languages fit this model exactly.

Interpreted languages (scripting languages) run code on top of their own interpreter, which is written in a compiled language.  [if there is interest, can talk about interpreter / bytecode / bytecode interpreter / JIT compilation / etc]

Some languages, like Java and C#, live somewhere in the middle.  They're compiled into bytecode which can be run on a virtual machine.

REGARDLESS, all code run on a computer is assembly code, then machine code.  Don't lose sight of that connection.

Are there any disadvantages to using an HLL over assembly?

- Less control over generated code

## Introduction to C

The HLL we'll use for the remainder of the course is C.  C is one of the most widely used programming languages of all time - and is still used for a ton of huge / important projects:

- Kernel / OS: Linux, GNU
- Version Control: git
- Web Server: Apache, nginx
- Interpreter: Ruby, Python
- Databases: mysql, postgresql, redis
- Virtualization: vmware
- Almost anything embedded, device drivers

**C is a portable, higher-level assembly.  That's the way you should think about it.**

Great programmers use C very precisely to generate the exact assembly they want to perform a given task - so it's important to understand how the C constructs we'll learn about map to assembly.  I'll save that for a later lesson.

The reason it's still used in many modern applications is that it gives you a lot of control over the generated assembly - making it FAST and MEMORY EFFICIENT.

### Comments
```
// Single line comment

/* block comment that can span 
multiple lines */

int i = 0;  // a declaration

/*************************************
  ** The previous variable was
  ** declared just as an example.
*************************************/
```

### Variables

#### Variable Types
| Type | Size | Description |
| :---: | :---: | :---: |
| char | 1 byte | number or ASCII character |
| int | 2 bytes | larger number |
| float | 2 bytes | single-precision floating point number |
| double | 4 bytes | double-precision floating point number |

- **Note**: These sizes are dependent on the compiler and target architecture - these are for the MSP430.
- **Note**: Do not use the float / double types on the MSP430 - since it doesn't have floating point hardware support, implementing software support will use almost all of your memory.

#### Variable Modifiers
| Modifier | Description |
| :---: | :---: |
| short | remains a 2-byte integer |
| long | increases int size to 4 bytes |
| signed | two's complement numbers (default) |
| unsigned | allows unsigned arithmetic |
| static | directly allocates memory to remember a value between function calls.  Variable is allocated to "permanent" memory, not the stack. |
| extern | atual storage and initial value of variable is defined elsewhere |
| const | assigns a constant (read-only) value to a variable |

- **Note**: Once again, sizes are dependent on compiler / target architecture - these are for the MSP430.

### Preferred Constant Declaration

The `#define` statment is a pre-processor directive.  The pre-processor will go through and replace each instant of the variable with the value before compilation, similar to a `.equ` statement in assembly.

```
// #define MY_CONST some_value

#define SCREEN_WIDTH 640
#define SCREEN_HEIGHT 480

int numPixels = 0;
numPixels = SCREEN_WIDTH * SCREEN_HEIGHT;
```
- **Note**: There is no ';' or '=' in *#define* statements
- **Note**: Variables must be declared at the top of a block, and they are not initialized by default.  A block is denoted by braces `{}`
- **Note**: A value can be binary (0b), octal (0), or hex (0x) by using prefixes.

### Assignment, Arithmetic Operators

```
char myVar, a, b;  // variable declaration

myVar = a;  // assignment - note, all vars have undefined values at this point

myVar = a + b;  // addition
myVar = a - b;  // subtraction
myVar = a * b;  // multiplication
myVar = a / b;  // division

myVar = a % b;  // modulus (remainder)

myVar++;        // increment
myVar--;        // decrement

myVar += a;     // myVar = myVar + a
myVar -= a;     // myVar = myVar - a
```

### Relational Operators

| Operator | Description | Example |
| --- | :---: | --- |
| `<` | less than | |
| `<=` | less than or equal to | |
| `>` | greater than | |
| `>=` | greater than or equal to | |
| `==` | equal to | |
| `!=` | not equal to | |
| `&&` | logical and | |
| ** &#32; &#124;&#124; ** | logical or | | |


Example:

```
if ((a < 10) && (a > 5)) 
{
    // literally: if a is greater than 5 and less than 10, do whatever is in here
    // practically: if a is between 5 and 10, do whatever is in here
}
```

- **Note**: In C, "false" is 0, while any non-zero value is considered true.

### Bit-wise Operators

| Operator | Description | Example |
| :-: | :-: | :-: |
| `&` | AND | |
| ** &#32; &#124; ** | OR | |
| `^` | XOR | |
| `~` | One's Complement | |
| `>>` | Bit-shift right | |
| `<<` | Bit-shift left | | |

```
// Example with SPI

UCA0CTL1 &= ~UCSWRST;            // disable the subsystem (AND UCA0CTL1 with NOT UCSWRST)

// Do config stuff in here

UCA0CTL1 |= UCSWRST;             // enable the subsystem (OR UCA0CTL1 with UCSWRST)
```

### if Statement

Conditional code execution based on a logical expression.

General case:
```
if (logical expression) 
{
    statements;
} else if (logical expression)
{
    statements;
}
...
else
{
    statements;
}
```

Example:
```
if (temp < MIN_TEMP) 
{
    flag = TOO_LOW;
} else if (temp > MAX_TEMP)
{
    flag = TOO_HIGH;
}
else
{
    flag = JUST_RIGHT;
}
```

### switch Statement

Conditional code execution based on a value.

General case:
```
switch (value)
{
    case constant-expression1:
        statements;
        break;
    case constant-expression2:
        statements;
        break;
    default:
        // gets executed if no other case hits
        statements;
        break;
}
```

Example:
```
switch (GAME_STATE)
{
    case MENU:
        displayMenu();
        break;
    case PLAYING:
        updateState();
        break;
    case LOST:
        displayLost();
        break;
}
```

### for Loop

Looping construct that tests logical expression and performs operation on an iterator variable.

General case:
```
for (initial; continue; increment)
{
    statements;
}
```

- initial - evaluated once, immediately before the first iteration of the loop.  Usually used to initialize variable.
- continue - condition checked to execute the next iteration.  If false, then the loop terminates.
- increment - single statement executed at the end of each loop.  Usually used to increment / decrement a variable.

Example case:
```
for (i = 1; i <= 20; i++)
{
    sum += i;
}
```

### while / do while Loop

Looping construct dependent on a logical expression.

General case:
```
while (condition) {
    statements;
}

do
{
    statements;
} while (condition);
```

*do while* is guaranteed to be executed once, *while* isn't.

Example:
```
int i = 5;

while (i < 10)
{
    i++;
}

do {
    i++
} while (i < 10);

// final value of i is 11
```

### Basic C Program Structure

General case:
```
// #include statements
// #define statements

// global variables

void main(void)
{
    // Variable declarations
    // Useful code

    while (1) {}        // trap the CPU
}
```
Example:
```
#include "helper.h"
#define NUM_LOOPS 23

void main(void)
{
    unsigned char i;
    unsigned int summation = 0;

    for (i = 1; i <= NUM_LOOPS; i++)
    {
        summation += i;
    }

    while (1) {}        // trap the CPU

}
```

### Header Example

Don't forget your code style!

```
/*--------------------------------------------------------------------
Name: <Your Name>
Date: <The date you stated working on the file>
Course: <The course's name>
File: <This file's name>
Event: <HW# and name>

Purp: A brief description of what this program does and 
    the general solution strategy. 

Doc:    <list the names of the people who you helped>
        <list the names of the people who assisted you>

Academic Integrity Statement: I certify that, while others may have 
assisted me in brain storming, debugging and validating this program, 
the program itself is my own work. I understand that submitting code 
which is the work of other individuals is a violation of the honor   
code.  I also understand that if I knowingly give my original work to 
another individual is also a violation of the honor code. 
-------------------------------------------------------------------------*/
```
