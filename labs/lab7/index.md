title = 'Lab 7 - A/D Conversion - "Robot Sensing"'

# Lab 7 - "Robot Sensing"

[Teaching Notes](notes.html)

**[A Note On Robot Sharing](/382/labs/lab6/other_peoples_robots.html)**

## Overview

This lab is designed to assist you in learning the concepts associated with the input capture features for your MSP430.  A single ultrasonic rangefinder is attached to a servo motor that can rotate.  You will program your MSP430 to use the rangefinder to determine whether your mobile robot is approaching a wall in front or on one of its sides.  The skills you will learn from this lab will come in handy in the future as you start interfacing multiple systems.

## Sensor Boards

Each robot has one rangefinder/servo pair.  By using the headers available to you on the top of the robot PCB, you can read a pulsewidth that is proportional to the distance between an object and the sensor. You will need to send the servo a pulse of a particular length in order to rotate the sensor to each side and back to the center position.

![Servo pulses](learn_arduino_servos.png)

For more information on servos, see the Seattle Robotics Society page on ["What is a Servo?"](http://www.seattlerobotics.org/guide/servos.html)

## Prelab (20 pts)

See the following [Prelab page](Prelab.html).

## Required Functionality (40 pts)

Use the Timer_A subsystem to light LEDs based on the presence of a wall.  The presence of a wall on the left side of the robot should light LED1 on your Launchpad board.  The presence of a wall next to the right side should light LED2 on your Launchpad board.  A wall in front should light both LEDs.  Demonstrate that the LEDs do not light until the sensor comes into close proximity with a wall.  Practically, what "close proximity" means depends on how fast you expect your robot to be moving.

## Sensor Characterization (15 pts)

You need to fully characterize the sensor for your robot.  Create a table and graphical plot with *at least* three data points that shows the rangefinder pulse lengths for a variety of distances from a maze wall to the front/side of your robot.  You should see a linear relationship between the points.  This table/graph should be generated for only **one servo position**.  Use these values to determine how your sensor works so you can properly use it with the servo to solve the maze.  **How do these experimental values compare to the timing values that you calculated in the Prelab?**

## Remote Functionality (15 pts)

Control your servo position with your remote!  Use remote buttons other than those you have used for the motors.  Note: you still need to be able to get readings from the ultrasonic sensor after changing your servo position with the remote.

## Ultrasonic Library Bonus (5 pts)

Create a standalone library for your ultrasonic code and release it to your instructor on a private Bitbucket repository.  This should be separate folder from your lab code.  It should have a thoughtful interface and README, and **you must use it in the robot maze laboratory (Lab 8)**.

## Servo Tester Bonus (10 pts)

Use a potentiometer to create an analog servo position selector input to your MSP430.  The analog value on this input will translate to a corresponding PWM value for your servo and allow you to sweep your servo position from side to side and anywhere in between.  This will operate similar to the servo tester demonstrated in class.
Answer the following questions in your main servo tester code file and be able to explain during a demo you provide to an instructor. 

1.  What voltage range did you select for your potentiometer analog servo position selector input and why?

2.  What values did you choose for `VR+` and `VR-`. 

3.  What calculations did you use to translate your input reference voltages to the different PWM values for the servo positions?

## Lab Hints

- The ultrasonic sensor does not require the trigger pulse to be exactly 10us.  Thus, you can simply delay a few clock cycles instead of using a timer.
- Test your ultrasonic sensor in one servo position first
- Verify ultrasonic signal in logic analyzer
  - Does the return pulse width change consistently as expected based on the actual distance?
  - Do the counts match as expected?
  - Make sure you are not reading the distance to the metal stand off post
- You can use port interrupts to detect the ultrasonic sensor echo (like Lab 5)
- Are you properly handling longer distances?  For instance, if the maze door is open will your robot think it sees a distance that is out of range or simply a wall?
  - Your timer rollover period and what you do when a rollover occurs matters here.
- Only use the ultrasonic sensor when you are NOT moving the servo
  - Realize that it may take longer (more PWM pulses) to move the servo than you think.  Be CONSERVATIVE
  - Moving the servo from the left side to the right side takes a lot longer than from the left side to the center
  - Make sure you are not reading the distance to the metal stand off post
- Verify the PWM signal you send to the servo using an o-scope
- Be sure you write a quality header/implementation file so you can easily import this code for the maze competition.


## Grading - Lab 7
[Printable Lab 7 Cutsheet](Lab_7_Cutsheet.pdf)

**Name:**<br>
<br>
**Section:**
<br>
<br>
**Documentation:**<br>
<br>

| **Item**                     | **Grade**                                                                                                          | **Points** | **Out of** | **Date** | **Due** |
|------------------------------|--------------------------------------------------------------------------------------------------------------------|------------|------------|----------|---------|
| **Prelab**                   | **On-Time** ----------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days |            | 20         |          | BOC L37 |
| **Required Functionality**   | **On-Time** ----------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days |            | 40         |          | COB L38 |
| **Sensor Characterization**  | **On-Time** ----------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days |            | 15         |          | COB L38 |
| **Remote Functionality**     | **On-Time** ----------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days |            | 15         |          | COB L38 |
| *Ultrasonic Library (Bonus)* | **On-Time** ----------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days |            | *5*        |          | COB L38 |
| *Servo Tester (Bonus)*       | **On-Time** ----------------------------------------------------- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days |            | *10*       |          | COB L38 |
| **Code**                     | **On-Time** Zero ---- Check Minus ---- Check ---- Check Plus ---- **Late:** 1Day ---- 2Days ---- 3Days ---- 4+Days |            | 10         |          | COB L38 |
| **Total**                    |                                                                                                                    |            | **100**    |          |         |
