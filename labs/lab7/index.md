title = 'Lab 7 - A/D Conversion - "Robot Sensing"'

# Lab 7 - "Robot Sensing"

[Teaching Notes](notes.html)

**[A Note On Robot Sharing](/labs/lab6/other_peoples_robots.html)**

## Overview

This lab is designed to assist you in learning the concepts associated with the input capture features for your MSP430.  A single ultrasonic rangefinder is attached to a servo motor that can rotate.  You will program your MSP430 to use the rangefinder to determine whether your mobile robot is approaching a wall in front or on one of its sides.  The skills you will learn from this lab will come in handy in the future as you start interfacing multiple systems.

## Sensor Boards

Each robot has one rangefinder/servo pair.  By using the headers available to you on the top of the robot PCB, you can read a pulsewidth that is proportional to the distance between an object and the sensor. 

## Required Functionality

Use the ADC subsystem to light LEDs based on the presence of a wall.  The presence of a wall on the left side of the robot should light LED1 on your Launchpad board.  The presence of a wall next to the right side should light LED2 on your Launchpad board.  A wall in front should light both LEDs.  Demonstrate that the LEDs do not light until the sensor comes into close proximity with a wall.

## B Functionality

You need to fully characterize the sensor for your robot.  Create a table and graphical plot that shows the rangefinder pulse lengths for a variety of distances from a maze wall.  This table/graph must be generated for three different servo positions.  Use these values to determine how your sensor/servo pair works so you can properly use them to solve the maze.

## A Functionality

Demonstrate your robot moving through an 18" corridor for six feet without touching a wall.

## Bonus Functionality

Create a standalone library for your ultrasonic code and release it on Bitbucket.  This should be separate from your lab code.  It should have a thoughtful interface and README, capable of being reused in the robot maze laboratory.  This particular repository should be publicly accessible.

## Prelab

Include whatever information from this lab you think will be useful in creating your program.

Consider how you'll setup the input capture subsystem.  What are the registers you'll need to use?  Which bits in those registers are important?  What's the initialization sequence you'll need?

Consider the hardware interface.  Which signals will you use?  Which pins correspond to those signalss?

Consider the interface you'll create to your sensor.  Will you block or use interrupts?  Will you stop moving while you sense?

## Lab Hints

- Be sure you write a quality header/implementation file so you can easily import this code for the maze competition.


## Grading

| Item | Grade | Points | Out of | Date | Due |
|:-: | :-: | :-: | :-: | :-: |
| Prelab | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus | | 10 | | BOC L37 |
| Required Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 40 | | COB L38 |
| B Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L38 |
| A Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L38 |
| Bonus Functionality | **On-Time** ------------------------------------------------------------------ **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 5 | | COB L38 |
| Use of Git | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L40 |
| Code Style | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L40 |
| README | **On-Time:** 0 ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days| | 10 | | COB L40 |
| **Total** | | | **100** | | |
