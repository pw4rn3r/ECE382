#include <msp430g2553.h>

extern void initMSP();
extern void initLCD();
extern void clearScreen();
extern void drawBox(unsigned int col, unsigned int row);

#define		TRUE			1
#define		FALSE			0
#define		UP_BUTTON		(P2IN & BIT2)

void main() {

	unsigned int	x, y, button_press;

	// === Initialize system ================================================
	IFG1=0; /* clear interrupt flag1 */
	WDTCTL=WDTPW+WDTHOLD; /* stop WD */
	button_press = FALSE;

	initMSP();
	initLCD();
	
	x=4;		y=4;
	drawBox(x, y);

	while(1) {
		if (UP_BUTTON == 0){
			y = y - 10;
			drawBox(x, y);
		}
		//the bulk of your code goes here


			}

}
