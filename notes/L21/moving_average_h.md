```
/*--------------------------------------------------------------------
Name: Capt Jeff Falkinburg
Date: 20 July 2016
Course: ECE 382
File: moving_average.h
Event: Assignment 8 - Moving Average 

Purp: Functions to update and monitor a moving average 

Doc:    <list the names of the people who you helped>
        <list the names of the people who assisted you>

Academic Integrity Statement: I certify that, while others may have 
assisted me in brain storming, debugging and validating this program, 
the program itself is my own work. I understand that submitting code 
which is the work of other individuals is a violation of the honor   
code.  I also understand that if I knowingly give my original work to 
another individual is also a violation of the honor code. 
-------------------------------------------------------------------------*/

#ifndef _MOV_AVG_H
#define _MOV_AVG_H

// Moving average functions
int getAverage(int array[], unsigned int arrayLength);
void addSample(int sample, int array[], unsigned int arrayLength);

// Array functions
int max(int array[], unsigned int arrayLength);
int min(int array[], unsigned int arrayLength);
unsigned int range(int array[], unsigned int arrayLength);

#endif
```
