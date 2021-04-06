	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
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
; �crire le code ici		

	EXPORT CallbackSon
	EXTERN Son

CallbackSon proc
	
	LDR R0,=IndexTable
	LDR R3,=SortieSon
	LDR R1,[R0] ; On stocke dans R1 : la valeur de R0
	cmp R1, #0 ; si IndexTable est �gal � 0 : initialisation
	beq Init
	
Continue_Callback

	ADD R1,#2
	STR R1, [R0] ; Mise � jour de IndexTable (d�calage)
	LDRSH R1,[R1] ; S : signed / H : Half-word : On met la valeur de R1 dans R1
	MOV R2, #45
	MUL R1,R2
	ASR R1,#12 ; SDIV R1,R2 (au cas ou)
	ADD R1, #360 ; On replace les valeurs entre 0 et 719
	STR R1,[R3]
	BX LR
	
	
Init
	
	LDR R2,=Son
	STR R2, [R0] ; On stocke l'adresse du d�but du tableau Son dans IndexTable
	mov R1, R2 ; On move l'adresse du d�but de Son dans R1
	
	b Continue_Callback




	endp	
		
	END