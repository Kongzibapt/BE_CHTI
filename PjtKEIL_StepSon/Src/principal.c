

#include "DriverJeuLaser.h"

extern void CallbackSon(void);


int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

// configuration du Timer 4 en débordement 100ms
	
Timer_1234_Init_ff(TIM4,6552);

PWM_Init_ff( TIM3, 3, 720); // Canal 3, Période 10us => Fréquence 100kHz  
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	
// Activation des interruptions issues du Timer 4
	
Active_IT_Debordement_Timer(TIM4,2,CallbackSon);

	
	

//============================================================================	
	
	
while	(1)
	{
	}
}

