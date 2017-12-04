title = 'Lab 8 - Robot Maze'

# Lab 8 - Robot Maze

[Teaching Notes](notes.html)

**[A Note On Robot Sharing](/382/labs/lab6/other_peoples_robots.html)**

## Overview

During this lab, you will combine the previous laboratory assignments and program your robot to autonomously navigate through a maze.  On the last day of the lab, each section will hold a competition to see who can solve the maze the fastest.  The fastest time in ECE 382 will have their name engraved on a plaque in the lab.  Believe it or not, the main goal of this lab is for you to have some fun with computer engineering!

## Requirements

You must write a program that autonomously navigates your robot through a maze (Figure 1) while meeting the following requirements:

1. Your robot must always start at the home position.
2. Your robot is considered successful only if it finds one of the three exits and moves partially out of the maze.
3. A large portion of your grade depends on which door you exit (see Figure 1 below):
  1. Door 1 Required Functionality (50 pts)
  2. Door 2 Functionality (15 pts)
  3. Door 3 Functionality (15 pts)
    - **You cannot hit a wall!**
  4. Bonus!  Navigate from Door 3 back to the entrance using the same algorithm.
    - **You cannot hit a wall!**
4. Provide a [cutsheet](Lab_8_Cutsheet.pdf) if another instructor checks your functionality
5. Your robot must solve the maze in less than three minutes.
6. Your robot will be stopped if it touches the wall more than twice.
7. You cannot hard code the path through the maze.  You must use your sense and avoid algorithms, along with your ultrasonic sensor, to navigate through the maze.

**Do not step onto the maze since the floor will not support your weight.  You will notice the maze floor is cracked from cadets who ignored this advice.**

![Maze Diagram](maze_diagram.png)

**Figure 1: Diagram of the maze your robot must navigate.  Your demonstration grade depends on which door you go through.**


## Competition Bonus

- Finisher - 5 pts
- Section Winner - 10 pts
- Course Winner - 15 pts

## Competition Requirements

All the laboratory requirements above are required to be met for the maze, with the following differences:

1. Each robot will get *only* three official attempts to complete the maze.  The best time will be used for your score.
2. You must notify a referee/instructor *before* you make an official attempt.
3. The robot with a lowest *adjusted* time will be the winner.
4. Each collision with a wall will add an additional 20 seconds to your total time.
5. Exiting Door 1 or Door 2 incurs a two or one minute penalty, respectively.


## Prelab

1.  Print out your grading sheet.

2.  Consider your maze navigation strategy.  **Provide pseudocode and/or a flowchart** that shows what your main program loop will do.
    - This should include your collision avoidance algorithm.

3.  Include whatever other information from this lab you think will be useful in creating your program.

#### Collision avoidance
How do you avoid hitting a wall?  Below are some questions for your consideration.

 - If your robot does not naturally drive perfectly straight, **how can you correct this "drift"**?

 - **How fast does your robot move?**  How far can it move in one full timing cycle?  What is a good way to figure this out?

 - **How fast can you determine "distance"** on each side of your robot (think worst case while moving)?  Should one side have more scanning priority, and how do you determine the priority?

 - If you follow a wall, what is a **good range of distances to attempt to be within?**


## Hints

Only the door you are trying to get functionality for will be open - all others will be closed.  We can't expect our robot to know to skip openings!

If you get A Functionality, you get credit for Required and B Functionality.  There is no need to complete the maze through all doors.

There are a variety of techniques that cadets have used in the past to solve the maze.  Here are a few:

- Use a wall-following algorithm (i.e., it tries to maintain a certain distance from the wall).
- Use an empty-space detecting algorithm.  If it gets too close to a wall, it steers away.

Additional hints are on the [Notes](notes.html) page.

## Grading - Lab 8

Provide a printable [Lab 8 Cutsheet](Lab_8_Cutsheet.pdf) if another instructor checks your functionality.

**Name:**<br>
<br>
**Section:**
<br>
<br>
**Documentation:**<br>
<br>

| **Item**                   | **Points** | **Out of** | **Verified by** | **Due** |
|----------------------------|------------|------------|-----------------|---------|
| **Prelab**                 |            | 10         |                 | BOC L39 |
| **Required Functionality** |            | 50         |                 | COB L40 |
| **Door 2 Functionality**   |            | 15         |                 | COB L40 |
| **Door 3 Functionality**   |            | 15         |                 | COB L40 |
| *Bonus Functionality*      |            | *5*        |                 | COB L40 |
| *Competition Bonus*        |            | *15*       |                 | EOC L40 |
| **Code (Required)**        |            | 10         |                 | COB L40 |
| **Total**                  |            | **100**    |                 |         |


**All Required lab work must be completed NLT COB Lesson 40. Otherwise a final
course grade of “Incomplete – Controllable” (IC) will be assigned.**