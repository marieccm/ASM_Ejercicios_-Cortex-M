
	AREA    codigo, CODE, READONLY,ALIGN=2
	THUMB
	EXPORT Start
	
Start	; Punto de entrada a partir del archivo Startup.

; Para enteros de hasta 12 bits o de la forma de segundo operador flexible.
	MOV		R2, #4095
	MOV		R3, #-99
	MOV 	R4, #0XFFF
	MOV 	R5, #0x01010101
	MVN		R6, #0x11001100		; Escribe 0xEEFFEEFF.
; Para enteros de hasta 32 bits.
	MOVW 	R7, #0xFDFD			; Bits menos significativos de R7.
	MOVT	R7, #0xCBCB			; Bits más significativos de R7.
	MOV32	R8, #2863311530
	
	ALIGN
	END							; Final del programa.