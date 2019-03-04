GPIO_PORTF2        EQU 0x40025010
GPIO_PORTF_DIR_R   EQU 0x40025400
GPIO_PORTF_AFSEL_R EQU 0x40025420
GPIO_PORTF_DEN_R   EQU 0x4002551C
GPIO_PORTF_AMSEL_R EQU 0x40025528
GPIO_PORTF_PCTL_R  EQU 0x4002552C
SYSCTL_RCGCGPIO_R  EQU 0x400FE608
CONSTANTE		   EQU 2000000
	
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
	; Paso 2: desbloqueo de pines. Es este caso los pines están libres.
		; En este programa no hay pines que necesiten desbloqueo.	
	; Paso 3: deshabilitar función analógica.
    LDR R1, =GPIO_PORTF_AMSEL_R   
	LDR R0, [R1] 	
    BIC R0, #0x04                      
    STR R0, [R1]
	; Paso 4: configurar como GPIO, PCTL=0.
    LDR R1, =GPIO_PORTF_PCTL_R      
    LDR R0, [R1]                    
    BIC R0, R0, #0x00000F00       
    STR R0, [R1]              
	; Paso 5: especificar dirección PF2.
    LDR R1, =GPIO_PORTF_DIR_R      
    LDR R0, [R1]                   
    ORR R0, R0, #0x04              
    STR R0, [R1]       		
	; Paso 6: limpiar bits en función alternativa.
    LDR R1, =GPIO_PORTF_AFSEL_R    
    LDR R0, [R1]                   
    BIC R0, R0, #0x04              
    STR R0, [R1]    
    ; Paso 7: habilitar como puerto digital.
    LDR R1, =GPIO_PORTF_DEN_R      
    LDR R0, [R1]                   
    ORR R0, R0, #0x04               
    STR R0, [R1]                        
	;		Regreso a rutina Start.
	B Loop 

Delay	; Rutina de retardo de 1s.
	ADD R0, #1
	NOP
	NOP
	NOP
	NOP
	CMP R0, R1
	BNE Delay
	BX LR
	
Loop	; Ciclo para encendido y apagadao de LED.
	; Cargar en R0 el contenido de la dirección de memoria a la que
	; apunta R1 (GPIO_PORTF2=0x40025010)
	LDR R1, =GPIO_PORTF2
    LDR R0, [R1]	 
	; Cambiar al valor del LED al negado del anterior (R0 = R0^0x04).	
    EOR R0, R0, #0x04 
	; Almacenar el valor de GPIO_PORTF2 modificado.
    STR R0, [R1]
	; Reiniciar contador para retardo e ir a Delay con enlace.
	LDR R0, =0
	LDR R1, =CONSTANTE
    BL Delay
	;Repetir subrutina Loop.
	B Loop
	
    ALIGN                           
    END  