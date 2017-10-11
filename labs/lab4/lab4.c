#include <msp430g2553.h>
#include <stdint.h>
#include <stdbool.h>
#include "color.h"

extern void initMSP();
extern void initLCD();
extern void clearScreen();
extern void drawBox(uint16_t col, uint16_t row, uint16_t color);

// Button press (active low) defines
#define		UP_BUTTON		!(P2IN & BIT2)

void main() {

	uint16_t x, y, fgColor;
	bool buttonPress = false;

	// === Initialize system ================================================
	IFG1 = 0; /* clear interrupt flag1 */
	WDTCTL = WDTPW+WDTHOLD; /* stop WD */
	
	initMSP();
	initLCD();
	
	x = 4;
	y = 4;
	fgColor = COLOR_16_STEEL_BLUE;
	
	drawBox(x, y, fgColor);

	while(true) { 			// move box on button press
		if (UP_BUTTON){
			y = y - 10;
			drawBox(x, y, fgColor);
		}
		//the bulk of your code goes here


	}
}
