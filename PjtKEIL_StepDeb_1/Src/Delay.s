	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0 ; On intialise VarTime � 0 (long)

	
; ===============================================================================================
	
;constantes (�quivalent du #define en C)
TimeValue	equ 900000 ; Constante


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani�re de cr�er une temporisation n'est clairement pas la bonne mani�re de proc�der :
; - elle est peu pr�cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc�s �cr/lec de variable en RAM
; - le m�canisme d'appel / retour sous programme
;
; et donc poss�de un int�r�t pour d�buter en ASM pur

Delay_100ms proc
	
	ldr r0,=VarTime  	; Lecture en m�moire : ,=   
					  
	ldr r1,=TimeValue   ; r1 = TimeValue
	str r1,[r0]  		; Ecriture en m�moire de r1 dans l'adresse contenue dans r0
		
BoucleTempo	
	ldr r1,[r0]     				
					
	subs r1,#1 ; soustraction qui met � jour le signe
	str  r1,[r0]
	bne	 BoucleTempo ; Ligne qui boucle sur BoucleTempo
		
	bx lr  ; Saut indirect par registre : retour de sous-programme
	endp
		
		
	END	