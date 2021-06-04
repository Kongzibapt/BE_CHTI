#include <stdio.h>

#include "DriverJeuLaser.h"

short int DFT_ModuleAuCarre(short int * Signal64ech, char k);
extern short int LeSignal[64];

int array[64];
short int dma_buf[64];
float res;

void callBack_Systick();

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

Init_TimingADC_ActiveADC_ff(ADC1,72);
Single_Channel_ADC( ADC1, 2 );
Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
Init_ADC1_DMA1( 0, dma_buf );
	
Systick_Period_ff(360000); // 360 000/72 0000 = 5ms
Systick_Prio_IT(2, callBack_Systick);
SysTick_On;
SysTick_Enable_IT;
	



//============================================================================	
	
	
// res = DFT_ModuleAuCarre(&LeSignal,1);

	while (1) {

	}

}

void callBack_Systick()
{
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	
	for (int i=0 ; i <64;i++){
		array[i] = DFT_ModuleAuCarre(dma_buf,i);
	}
	Stop_DMA1;
	
}

