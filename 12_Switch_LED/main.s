GPIO_PORTF12       EQU 0x40025018
GPIO_PORTF0        EQU 0x40025004
GPIO_PORTF_DIR_R   EQU 0x40025400
GPIO_PORTF_AFSEL_R EQU 0x40025420
GPIO_PORTF_DEN_R   EQU 0x4002551C
GPIO_PORTF_LOCK_R  EQU 0x40025520
GPIO_PORTF_AMSEL_R EQU 0x40025528
GPIO_PORTF_PCTL_R  EQU 0x4002552C
SYSCTL_RCGCGPIO_R  EQU 0x400FE608
GPIO_LOCK_KEY	   EQU 0x4C4F434B 
GPIO_PORTF_CR_R    EQU 0x40025524
CONSTANTE		   EQU 100000
	
		 AREA    codigo, CODE, READONLY,ALIGN=2
		 THUMB
		 EXPORT Start 

Start
	; Paso 1: activación de reloj para puerto F.
    LDR R1, =SYSCTL_RCGCGPIO_R
    LDR R0, [R1]                   
    ORR R0, R0, #0x20            
    STR R0, [R1]                   
    NOP
    NOP                          
	; Paso 2: desbloqueo de pines.
	LDR R1, =GPIO_PORTF_LOCK_R	; uso de llave
	LDR R0, =GPIO_LOCK_KEY                     
    STR R0, [R1]
    LDR R1, =GPIO_PORTF_CR_R    ; "commit"
    MOV R0, #0xFF                   
    STR R0, [R1]                    
	; Paso 3: deshabilitar función analógica.
    LDR R1, =GPIO_PORTF_AMSEL_R   
	LDR R0, [R1] 	
    BIC R0, #0x07                      
    STR R0, [R1]
	; Paso 4: configurar como GPIO, PCTL=0.
    LDR R1, =GPIO_PORTF_PCTL_R      
    LDR R0, [R1]                    
    BIC R0, R0, #0x000000FF  
	BIC R0, R0, #0x00000F00	
    STR R0, [R1]              
	; Paso 5: especificar dirección de PF1 y PF2.
    LDR R1, =GPIO_PORTF_DIR_R      
    LDR R0, [R1]                   
    ORR R0, R0, #0x06              
    STR R0, [R1]  
	; Paso 5: especificar dirección de PF0.
	LDR R1, =GPIO_PORTF_DIR_R      
    LDR R0, [R1]                   
    BIC R0, R0, #0x01              
    STR R0, [R1]  	
	; Paso 6: limpiar bits en función alternativa.
    LDR R1, =GPIO_PORTF_AFSEL_R    
    LDR R0, [R1]                   
    BIC R0, R0, #0x07              
    STR R0, [R1]    
    ; Paso 7: habilitar como puerto digital.
    LDR R1, =GPIO_PORTF_DEN_R      
    LDR R0, [R1]                   
    ORR R0, R0, #0x07               
    STR R0, [R1]                        
	
	LDR R3, =CONSTANTE
	B Loop 

Delay	; Rutina de retardo de 50ms.
	ADD R2, #1
	NOP
	NOP
	NOP
	NOP
	CMP R2, R3
	BNE Delay
	BX LR

Encender ; Rutina de encendido de F1 y F2.
	LDR R5, =GPIO_PORTF12
	LDR R4, =0x06
	STR R4, [R5]
	B Loop
Apagar	; Rutina de apagado de F1 y F2.
	LDR R5, =GPIO_PORTF12
	LDR R4, =0x0
	STR R4, [R5]
	B Loop
	
Loop	; Ciclo para lectura de switch.
	; Leer el valor del switch.
	LDR R1, =GPIO_PORTF0
	LDR R0, [R1]
	;Retardo antirrebote.
	LDR R2, =0
	BL Delay
	; Si F0=1, encender LED. Si F0=0, apagar LED.
	CMP R0, #0x01
	BEQ Encender
	CMP R0, #0x0
	BEQ Apagar
	B Loop
	
    ALIGN                           
    END  