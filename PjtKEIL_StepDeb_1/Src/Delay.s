	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
VarTime	dcd 0 ; On intialise VarTime à 0 (long)

	
; ===============================================================================================
	
;constantes (équivalent du #define en C)
TimeValue	equ 900000 ; Constante


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette manière de créer une temporisation n'est clairement pas la bonne manière de procéder :
; - elle est peu précise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'accés écr/lec de variable en RAM
; - le mécanisme d'appel / retour sous programme
;
; et donc possède un intérêt pour débuter en ASM pur

Delay_100ms proc
	
	ldr r0,=VarTime  	; Lecture en mémoire : ,=   
					  
	ldr r1,=TimeValue   ; r1 = TimeValue
	str r1,[r0]  		; Ecriture en mémoire de r1 dans l'adresse contenue dans r0
		
BoucleTempo	
	ldr r1,[r0]     				
					
	subs r1,#1 ; soustraction qui met à jour le signe
	str  r1,[r0]
	bne	 BoucleTempo ; Ligne qui boucle sur BoucleTempo
		
	bx lr  ; Saut indirect par registre : retour de sous-programme
	endp
		
		
	END	