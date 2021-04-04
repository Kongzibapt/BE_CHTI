	PRESERVE8
	THUMB   
		
	include ../Driver/DriverJeuLaser.inc

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
FlagCligno dcd 0
	
	
	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		
	
	EXPORT timer_callback

timer_callback proc
	
	push {lr}
	ldr r0,=FlagCligno
	ldr r1,[r0]
	cmp r1,#1
	beq A
	mov r2,#1 ; else
	str r2,[r0]
	mov r0, #1
 	bl GPIOB_Clear
	b C
	
A ; if
	mov r2,#0
	str r2,[r0]
	mov r0, #1
	bl GPIOB_Set

C ; end if		
	pop {pc}
	endp
		
		
	END	