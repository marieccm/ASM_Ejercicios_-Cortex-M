DIRECCION	EQU	0x20000008 ; Dirección en RAM.
	
	AREA    codigo, CODE, READONLY,ALIGN=2
	THUMB
	EXPORT Start
	
Start ; Punto de entrada a partir del archivo Startup.
	MOV32 R1, DIRECCION
	
	; Uso de pseudoinstrucción alternativa LDR Rn, =constante.
	LDR	R2, = 108900
	LDR	R3, = 12345
	LDR	R4, = 8000
	LDR	R5, = 752
	
	; Almacenamiento de valores a RAM individualmente con aumento
	; de 4 bytes en dirección cada vez.
	STR R2, [R1], #4
	STR R3, [R1], #4
	; Almacenamiento colectivo de R4 y R5 en RAM.
	STM R1, {R4, R5}
	MOV32 R1, DIRECCION ; Reinicio de dirección.
	
	; Carga colectiva desde RAM a registros R6, R7 y R8.
	LDM R1!,{R6,R7,R8}
	; Carga individual desde RAM a R9 con la última dirección.
	LDR R9, [R1]

	ALIGN
	END	