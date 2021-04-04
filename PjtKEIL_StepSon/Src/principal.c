

#include "DriverJeuLaser.h"

extern void CallbackSon(void);


int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();

// configuration du Timer 4 en d�bordement 100ms
	
Timer_1234_Init_ff(TIM4,655.2);
	
	
// Activation des interruptions issues du Timer 4
	
Active_IT_Debordement_Timer(TIM4,2,CallbackSon);

	
	

//============================================================================	
	
	
while	(1)
	{
	}
}

