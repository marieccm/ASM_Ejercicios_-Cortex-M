	AREA    codigo, CODE, READONLY,ALIGN=2
	THUMB
	EXPORT Start
	
Start
	VLDR.F32 S0, =1		; Contador (n).
	VLDR.F32 S1, =1		; Constante 1.
	VLDR.F32 S4, =50	; Límite superior.
	
Sumatoria	; Ciclo de sumatoria.
	VDIV.F32 S2, S1, S0	; S2=1/n
	VADD.F32 S3, S2		; S3 almacena la sumatoria.
	VADD.F32 S0, S1		; Incrementar n.
	; Verificar si n llegó a límite superior.
	VCMP.F32 S0, S4		
	VMRS APSR_nzcv, FPSCR
	BLO Sumatoria 		; Saltar si es menor (C=0).
	
Loop		; Ciclo sin fin.
	B Loop
	
	ALIGN
	END	