	AREA codigo, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start
		
Start
	LDR R0, =0
	LDR R1, =2000000
		
Delay
	ADD R0, #1 ; Sumar 1 al valor anterior de R0.
	NOP
	NOP
	NOP
	NOP
	
	CMP R0, R1; Comparar R0 con constante.
	BNE Delay ; Si R0!=2000000 repetir subrutina Delay.
	
Loop
	B Loop ; Ciclo sin salida
	
	ALIGN
	END