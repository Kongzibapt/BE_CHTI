	PRESERVE8
	THUMB  

	include ../Driver/DriverJeuLaser.inc
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
SortieSon dcd 0
IndexTable dcd 0
	
	EXPORT SortieSon
	EXPORT IndexTable
	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		

	EXPORT CallbackSon
	EXTERN Son
	EXTERN CLOCK_Configure
	EXTERN Timer_1234_Init_ff
	EXTERN PWM_Init_ff

CallbackSon proc ; A partir des valeurs du tableau Son, 
		 ; convertit les valeurs pour qu'elles soient entre 0 et 719 (*45/4096) 
		 ; et on met ces valeurs dans SortieSon
	
	PUSH {R4, R5, R6, R7, LR} 
	LDR R7,=IndexTable
	LDR R6,=SortieSon
	LDR R4,[R7]
	cmp R4, #0 ; 
	beq Init
	
Continue_Callback

	ADD R4,#2
	STR R4, [R7] ; Mise à jour de IndexTable (décalage)
	LDRSH R4,[R4] ; S : signed / H : Half-word
	MOV R5, #45 
	MUL R4,R5
	ASR R4,#12 ; On fait l'opération *(45/4096)
	ADD R4, #360 ; On décale les valeurs pour qu'elles soient entre 0 et 719
	STR R4,[R6]
	MOV R0, R4
	BL PWM_Set_Value_TIM3_Ch3
	POP {R4, R5, R6, R7, PC}
	
	
Init ; initialisation des registres
	
	LDR R5,=Son
	STR R5, [R7] ; On stocke l'adresse du début du tableau Son dans IndexTable
	mov R4, R5 ; On move l'adresse du début de Son dans R1
	
	b Continue_Callback




	endp	


StartSon proc ; lanceur de séquence

    ldr r0,=IndexTable
    mov r1, #0
    str r1, [r0]
    bx lr
    endp
	
	END