title = 'Lab 7 - A/D Conversion - "Robot Sensing" Prelab'

# Lab 7 - "Robot Sensing" Prelab

**Name:**
<br>
<br>
**Section:**
<br>
<br>
**Documentation:**
<br>
<br>
<br>
Part I - Understanding the Ultrasonic Sensor and Servo
------------------------------------------------------

**Read the datasheets and answer the following questions**


#### Ultrasonic Sensor 
1.  How fast does the signal pulse from the sensors travel?

2.  If the distance away from the sensor is 1 in, how long does it take for the
    sensor pulse to return to the sensor?  1 cm?

3.  What is the range and accuracy of the sensor?

4.  What is the minimum recommended delay cycle (in ms) for using the sensor?  How does this compare to the "working frequency"?

    **Going further (optional):**
    Given the max "working frequency", does the maximum sensor range
    make sense?  <u>Hint</u>:  find the maximum unambiguous range.


#### Servo
1.  Fill out the following table identifying the pulse lengths needed for each servo position:

| Servo Position | Pulse Length (ms) | Pulse Length (counts) |
|----------------|:-----------------:|:---------------------:|
| Left           |                   |                       |
| Middle         |                   |                       |
| Right          |                   |                       ||
    
<br>

Part II - Using the Ultrasonic Sensor and Servo
-----------------------------------------------

1. Create psuedocode and/or flowchart showing how you will *setup* and *use* the ultrasonic sensor and servo.

2. Create a schematic showing how you will setup the ultrasonic sensor and servo.

3. Include any other information from this lab you think will be useful in creating your program.  Small snippets from datasheets such as the ultrasonic sensor timing may be good for your report.

**Below are some things you should think about as you design your interfaces:**

 - **Consider if/how you will configure the input capture subsystem** for your ultrasonic sensor.  What are the registers you will need to use?  Which bits in those registers are important?  What is the initialization sequence you will need?  Should you put a limit on how long to sense?  If so, how long makes sense given the limitations of the sensor (or the requirements of the project)?

 - **Consider the hardware interface.**  Which signals will you use?  Which pins correspond to those signals?  How will you send a particular pulse width to the servo?

 - **Consider the software interface you will create to your sensor.**  Will you block or use interrupts?  Will you stop moving while you sense?

 - Will the ultrasonic sensor be ready to sense immediately after the servo changes position?  How do you know? 

 - How long should you keep sending PWM pulses?  Keep in mind that you may have to send many PWM pulses before your servo is in the correct position.  Even after that, can you stop sending PWM pulses?
 
 - **Consider how to make your code extensible.**  It will be easier to achieve the bonus functionality of creating an ultrasonic library if you design it right from the beginning.  You should also consider how you will make the sensor and servo work together.

