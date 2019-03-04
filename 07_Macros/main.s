	AREA codigo, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start
		
Start
	LDR R8, =4
	
	MACRO  
; prom = (a + b + c + d)/4
$etiqueta Promedio $prom, $a, $b, $c, $d
$etiqueta  
	ADD	R10 , $a, $b
	ADD	R10 , $c
	ADD	R10 , $d
	SDIV $prom, R10, R8	; dividir en 4
	MEND


	LDR R0, =10
	LDR R1, =20
	LDR R2, =15
	LDR R3, =31
_Prom1 Promedio R4, R0, R1, R2, R3
	
	LDR R0, =6
	LDR R1, =8
	LDR R2, =9
	LDR R3, =5
_Prom2 Promedio R5, R0, R1, R2, R3
	
Loop
	B Loop

	ALIGN
	END