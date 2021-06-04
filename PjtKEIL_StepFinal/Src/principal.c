#include <stdio.h>
#include "../ModuleAffichage/Affichage_Valise.h"
#include "DriverJeuLaser.h"

extern void CallbackSon(void);
short int DFT_ModuleAuCarre(short int * Signal64ech, char k);
extern short int LeSignal[64];

int array[64];
short int dma_buf[64];
float res;
int score[6] = {0,0,0,0,0,0};
int seuil = 0x01000000;

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
	
// SON
Timer_1234_Init_ff(TIM4,6552);
PWM_Init_ff( TIM3, 3, 720); // Canal 3, Période 10us => Fréquence 100kHz  
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
Active_IT_Debordement_Timer(TIM4,2,CallbackSon);

Init_Affichage();
//============================================================================	
	
	
// res = DFT_ModuleAuCarre(&LeSignal,1);

	while (1) {
		Prepare_Afficheur(1, score[0]);
		Prepare_Afficheur(2, score[1]);
		Prepare_Afficheur(3, score[2]);
		Prepare_Afficheur(4, score[3]);
	}

}

void callBack_Systick()
{
	int k;
	//GPIO_Set(GPIOB,1);
	
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	
	for (int i=0 ; i <4;i++){
		
		k = i + 17;
		if (DFT_ModuleAuCarre(dma_buf,k) >= seuil){
				score[i]++;
		}
	}
	Stop_DMA1;
	
	//GPIO_Clear(GPIOB,1);
	
}

