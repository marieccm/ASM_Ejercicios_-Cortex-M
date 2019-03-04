	AREA codigo, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start
		
Start
	; Cargar valores.
	LDR R0, =10
	LDR R1, =0
	
	; Comparar el contenido de R1 con 0. Si son iguales entonces Z=1.
	CBZ R1, Loop ; Saltar a Loop si R1=0 (no es posible dividir).
	
	SDIV R2, R0, R1 ; Sólo se llega a esta línea si R1!=0, se divide.
	
Loop
	B Loop ; Ciclo sin salida.
	
	ALIGN
	END