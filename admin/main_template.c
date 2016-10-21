/**********************************************************************
 
 COPYRIGHT 2016 United States Air Force Academy All rights reserved.
 
 United States Air Force Academy     __  _______ ___    _________ 
 Dept of Electrical &               / / / / ___//   |  / ____/   |
 Computer Engineering              / / / /\__ \/ /| | / /_  / /| |
 2354 Fairchild Drive Ste 2F6     / /_/ /___/ / ___ |/ __/ / ___ |
 USAF Academy, CO 80840           \____//____/_/  |_/_/   /_/  |_|
 
 ----------------------------------------------------------------------
 
   FILENAME      : main.c
   AUTHOR(S)     : Your Name
   DATE          : 10/5/2016
   COURSE		 : ECE 382
   
   Lesson/Hw/...e.g., Assignment 7
   
   DESCRIPTION   : This code simply provides a template for all  
                   C assignments to use.
                     - Be sure to include your *Documentation* 
                       Statement below!
 
   DOCUMENTATION : None
 
 Academic Integrity Statement: I certify that, while others may have
 assisted me in brain storming, debugging and validating this program,
 the program itself is my own work. I understand that submitting code
 which is the work of other individuals is a violation of the honor
 code.  I also understand that if I knowingly give my original work to
 another individual is also a violation of the honor code.
 
 **********************************************************************/

#include <msp430.h> 

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif


  /************************************************************************************/
 /* FUNCTION DECLARATIONS															 */
/************************************************************************************/

/**************************************************
   Function: name()
   Author: Your Name
   Description: 
   Inputs: 
   Returns: none
***************************************************/  



  /************************************************************************************/
 /* MAIN    																		 */
/************************************************************************************/
void main(void) {
    WDTCTL = WDTPW | WDTHOLD;	// Stop watchdog timer
	
	while(TRUE);
}
