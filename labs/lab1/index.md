title = 'Lab 1 - Assembly Language - "A Simple Calculator"'

# Lab 1 - Assembly Language - "A Simple Calculator"

[Teaching Notes](notes.html)

## Objectives

You'll write your first complete assembly language program using what you've learned in class.  You'll need all of the skills you've learned to this point - the instruction set, addressing modes, conditional jumps, status register flags, assembler directives, the assembly process, etc.  This lab will give you practice in using assembly to implement higher-level if/then/else and looping constructs.

## Details

### The Basic Idea

You'll write a program that interprets a series of operands and operations and stores the results - an assembly language calculator!

Your program will start reading at the location in ROM where you stored the calculator instructions.  It will read the first byte as the first operand.  The next byte will be an operation.  The third byte will be the second operand.  Your program will execute the expected operation and store the result starting at 0x0200.  The result will then be the first operand for the next operation.  The next byte will be an operation.  The following will be the second operand.  Your program will execute the requested operation and store the result at 0x0201.  Your program will continue doing this until you encounter an END_OP - at which point, your program will cease execution.

### Required Functionality

- The input and output for the calculator will be in memory locations.  The calculator operations and operands will be stored in ROM - any location in ROM is acceptable.  The results of the calculations will be stored in RAM starting at 0x0200.  Labels shall be used in the program to refer to the location of your instructions and results.
- The input operands and output results will be positive integers between 0 and 255 (an unsigned byte).
- Good coding standards (labels, .equ where appropriate) must be used throughout.

Your program will implement the following operations:

**ADD_OP**  
An addition operation is coded by the value 0x11.  It adds two numbers and stores the result.  
The calculator program `0x14 0x11 0x12` is equivalent to `0x14 + 0x12`.  It would store the result `0x26`.

**SUB_OP**  
An subtraction operation is coded by the value 0x22.  It subtracts two numbers and stores the result.  
The calculator program `0x21 0x22 0x01` is equivalent to `0x21 - 0x1`.  It would store the result `0x20`.

**CLR_OP**  
A clear operation, represented by the value 0x44, clears the result by storing `00` to memory.  It then uses the second operand as the initial value for the next operation.
The calculator program `0x21 0x22 0x01 0x44 0x14 0x11 0x12` is equivalent to `0x21 - 0x1 CLR 0x14 + 0x12`.  It would store `0x20 0x00 0x26`.

**END_OP**  
The end operation terminates execution of the calculator.  It is coded by the value 0x55.

Example calculator program: `0x14 0x11 0x32 0x22 0x08 0x44 0x04 0x11 0x08 0x55`  
It's equivalent to: `0x14 + 0x32 - 0x08 CLR 0x04 + 0x08 END`  
The result should be, stored at 0x0200: `0x46 0x3e 0x00 0x0c`

Your calculator will be tested with various combinations of input instructions.  Results will be verified using the debugger.

### B Functionality

In addition to the Required Functionality, your program will meet the following requirement:

- If a result exceeds 255, it is set to the maximum value of 255.  If a result is less than 0, it is set to the minimum value of 0.

### A Functionality

In addition to B Functionality, your program will implement a multiply operation:

**MUL_OP**  
An multiplication operation is coded by the value 0x33.  It multiplies two numbers and stores the result.  
The calculator program `0x02 0x33 0x04` is equivalent to `0x02 * 0x04`.  It would store the result `0x08`.

The MSP430G2553 that you're using does not have a hardware multiplier, so you'll have to get creative to implement this.

There are a couple of ways to implement multiply - **strive for the fastest possible, yet practical implementation**.  Solutions that multiply by brute force (worse than O(n) time) will receive half points.  Only solutions that multiply in O(n) or better time will receive full points.

O(n) means that the time it takes to reach a solution varies with the size of the input.  A typical brute force multiply algorithm requires O(2^n )!


## Prelab

**Remember, the Prelab is due one full business day prior to the lab in order to provide your instructor time to provide you feedback on your plan (before you start implementing it).**

Most prelabs in this class essentially require that you 1) lay out a plan for how you will tackle the lab, and 2) answer questions to guide you in developing a good plan.  A good plan usually requires multiple iterations.  Pages 17-18 and 55 of the Barret and Pack book provide a concise approach to design planning.

After you have carefully read through this document, make sure you understand the [test cases](test_cases.html).  Do the expected results make sense to you?  Make sure you understand how the input and output of the program will work.  Otherwise, you will be completely lost in implementing your program!

Now that you understand *what* your program should do, you can start developing a plan on *how* it will accomplish its tasks.  Start with sketching ideas on paper.  This may result in an initial flowchart or pseudocode.  You will likely find that working out the problem on paper will help you to understand the problem better.  Once you have developed a reasonable algorithm to implement your task, test it with [test cases](test_cases.html).  Adjust the plan as needed. 

Keep in mind that whenever you write any code, you should also consider what it should do in the event that you receive an invalid input.  Can you think of any invalid inputs in the context of this task?  Can you think of any inputs that might break the algorithm you have already developed?  For instance, what should your program do if an operator is unknown?  Are there any bytes that you cannot use an as operand?

Are there any other ways to break your program?  For example, what would happen if someone were to provide a loooooonnnggg set of operations?

Note, it is not expected that you will implement code that is unbreakable and completely robust.  **However, you should understand and DOCUMENT the limitations of your code.**


#### Prelab Deliverables

**Remember, the Prelab is due one full business day prior to the lab in order to provide your instructor time to provide you feedback on your plan (before you start implementing it).**

1. **Refine your plan, and develop a professional looking flowchart describing how your code will operate.**  Use traditional symbols in your flowchart as much as possible, and include a symbol key.  **Do not include assembly in your flowchart.**  Make it easy to read and understand.

2. Answer the following questions:

 - How will you test your code?  Be *specific* on how you will verify correctness of results with a *repeatable and consistent* method.  Hint:  Think about where you will find your results and how that location is affected by subsequent tests.
 - What should your program do if an operator is unknown?
 - Are there any bytes that you *cannot* use as an operand?
 - Are there any other ways to break your program?  For example, what would happen if someone were to provide a loooooonnnggg set of operations?
 - Is there anything about this lab that you would like me to address at the beginning of class?


## Notes

Read the [guidance on Labs / Lab Notebooks / Coding standards](/382/admin/labs.html) thoroughly and follow it.  Additional guidance is provided in the [teaching notes](notes.html) page.

- Comments
    - Assume the reader is a competent assembly language programmer (do NOT comment every line)
    - Comment above blocks of code to convey **purpose**
    - Only comment individual lines when purpose is unclear
- Labels
    - Descriptive!
        - `loop` or `loop1` or `l1` or `blah` - not acceptable!
    - Used for all memory location, jumps, etc. 
- Constants
    - Use `.equ` syntax for all constants!
    - Don't want to see naked values / magic numbers
- Instruction Choice
    - Use the instruction that makes your code readable!
        - `JHS` rather than `JC`
        - `INCD` rather than `ADD #2`
    - Well-written code requires few comments
- Spacing
    - Align your code to make it readable
    - Put whitespace between logical blocks of code

## Test Cases!

**In addition to using the test cases I have provided, create at least two test cases of your own.  Explain why your test cases provide added value in testing your program.  Be sure to include the expected results.**

[Test Cases](test_cases.html)

## Grading - Lab 1

#### Points breakdown
- Prelab 25 (15 flowchart, 10 questions)

- Req'd funct 30
- B funct 10
- A funct (Brute force multiply) 5
- A funct (O(n) multiply) 5

- Code 10
- Lab Notebook 15 (most of the notebook work is done with the prelab)
