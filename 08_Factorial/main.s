	AREA codigo, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start

Start
	VLDR.F32 S0, =30	; Número a operar (n!).
	VLDR.F32 S1, =1		; Registro para guardar resultado.	
	VLDR.F32 S30, =1	; Constante 1.
	
Factorial
	; Multiplicar el valor actual de n y el resultado acumulado.
	VMUL.F32 S1, S0		
	; Sustraer uno al valor actual de n.
	VSUB.F32 S0, S30
	; Verificar si se ha llegado a 1 (ya no quedan números por multiplicar).
	VCMP.F32 S0, S30	
	VMRS APSR_nzcv, FPSCR	; Trasladar banderas de FPSCR a APSR.
	BNE Factorial	; Si n no es igual a 1, seguir operando.
	
Loop
	B Loop
	
	ALIGN
	END