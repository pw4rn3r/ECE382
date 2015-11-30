# Lab 7 Notes

- **No walking in the mazes!**  You will break the floor!

- You can dead-reckon for the competition, not for functionality!  Functionality must use at least one sensor.

- If your chip is in the breadboard, you'll have to wire it to the appropriate pins on the Launchpad to light the LEDs.
- If you want to use P1.1 or P1.2, you should remove the TXD and RXD jumpers.

- Be mindful of your interface when writing code!  You'll want to hide all of this complexity in a library once you get to the maze.
  - `unsigned int getLeftSensorReading()` seems like a good prototype
  - `char isLeftSensorCloseToWall()` might be useful
  - Think about what you'll want access to in the maze!

- The code in the L36 notes uses interrupts - you don't necessarily have to do that.
  - The `ADC10IFG` flag indicates `ADC10MEM` has been loaded with a conversion result.  It is automatically reset if the interrupt request is accepted.
  - You can also poll this flag and reset it in software.


