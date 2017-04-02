;PUNTO NUMERO 1, LABORATORIO DE MICRIPROCESADORES
;Juan José NiNo Toro 201110101, Pedro Pablo Sanabria Paredes 201220728 
;PROGRAMA QUE CALCULA LAS OPERACIONES BASICAS "SUMA, RESTA MULTIPLICACION Y DIVISION" 



; Define el modelo de memoria

.MODEL SMALL

.Data                 
   

  ErrorCAP DB  0    ; Muestra algun error en la captura del mensaje
  Cantidad DB  0     ; La cantidad sobre la que se opera. Si es 0 se opera
                     ; sobre la cantidad 1, si es 1 se opera sobre la
                     ; cantidad 2                            
                      
  CantUnoR DW  0     ; Variable que guarda la cantidad 1 convertida a binario.
  CantDosR DW  0     ; Variable que guarda la cantidad 2 convertida a binario.
  CantUnoN DB  6,0,6 DUP(?)  ; Variable que almacena la cantidad 1 
  CantDosN DB  6,0,6 DUP(?)  ; Variable que almacena la cantidad 2     
  
  CantUnoR1 DW  0     ; Variable que guarda la cantidad 3 convertida a binario.
  CantDosR1 DW  0     ; Variable que guarda la cantidad 4 convertida a binario.
  CantUnoN1 DB  6,0,6 DUP(?)  ; Variable que almacena la cantidad 3 
  CantDosN1 DB  6,0,6 DUP(?)  ; Variable que almacena la cantidad 4   
  
  CantUnoR2 DW  0     ; Variable que guarda la cantidad 5 convertida a binario.
  CantDosR2 DW  0     ; Variable que guarda la cantidad 6 convertida a binario.
  CantUnoN2 DB  6,0,6 DUP(?)  ; Variable que almacena la cantidad 5 
  CantDosN2 DB  6,0,6 DUP(?)  ; Variable que almacena la cantidad 6     
  
  CantUnoR3 DW  0     ; Variable que guarda la cantidad 7 convertida a binario.
  CantDosR3 DW  0     ; Variable que guarda la cantidad 8 convertida a binario.
   
  CantUnoR4 DW  0     ; Variable que guarda la cantidad 9 convertida a binario.
  CantDosR4 DW  0     ; Variable que guarda la cantidad 10 convertida a binario.
  
  
 
  Resulta  DB  13,10,13,10,'El resultado NUMERO1 / NUMERO2 es: R1= $ ' 
  ResultaR DB  11 DUP('?')                           
  
  Resulta1  DB  13,10,13,10,'El resultado NUMERO3 * NUMERO4 es: R2= $' 
  ResultaR1 DB  11 DUP('?')                         
  
  Resulta2  DB  13,10,13,10,'El resultado  NUMERO5 + NUMERO6 es: R3= $' 
  ResultaR2 DB  11 DUP('?')     
  
  Resulta3  DB  13,10,13,10,'El resultado  R2 - R3 es: R4= $' 
  ResultaR3 DB  11 DUP('?')
   
  Resulta4  DB  13,10,13,10,'El resultado  R1 + R4 es RTOTAL : $' 
  ResultaR4 DB  11 DUP('?') 
                       
  Resulta5  DB  13,10,13,10,'FIN $'
  ResultaR5 DB  11 DUP('?') 
  
  
  
  Mensaje  DB  'OPERACIONES BASICAS'
  	       DB  13,10 
           DB  'SUMA, RESTA, MULTIPLICACION Y DIVICION '
           DB  13,10,13,10,'$'     
           
  

  Error1   DB  7,7,7,13,10,'ERROR : d¡gito INVALIDO en CANTIDAD 1.'
           DB  13,10,13,10,'$'
  Error2   DB  7,7,7,13,10,'ERROR : d¡gito INVALIDO en CANTIDAD 2.'
           DB  13,10,13,10,'$'
  Error3   DB  7,7,7,13,10,'ERROR : cantidad fuera de RANGO (65535).'
  	       DB  ' ????.'
           DB  13,10,13,10,'$'
  Error4   DB  7,7,7,13,10,'ERROR : intento de DIVISION por CERO.'
           DB  13,10,13,10,'$'
                                 
  
  
                                 
  CantunoM  DB  13,10,13,10,'Digite NUEMRO 1 '
  	        DB  ' : $'
  CantDosM  DB  13,10,13,10,'Digite NUEMRO 2'
  	        DB  ' : $'    	   

  CantunoM1 DB  13,10,13,10,'Digite NUEMRO 3'
  	        DB  ' : $'
  CantDosM1 DB  13,10,13,10,'Digite NUEMRO 4'
  	        DB  ' : $'  

  CantunoM2 DB  13,10,13,10,'Digite NUEMRO 5 '
  	        DB  ' : $'
  CantDosM2 DB  13,10,13,10,'Digite NUEMRO 6 '
  	        DB  ' : $'  
 


  Potencia  DW  0001h, 000ah, 0064h, 03E8h, 2710h
  PotenciaF DW  $        
  
                    

.CODE                       ; Area de c¢digo


Empieza:                    ; Etiqueta de comienzo de programa      
     


  Mov  Ah, 0Fh              ; Obtiene la modalidad de video actual
  Int  10h
  Mov  Ah, 0                ; Cambia la modalidad de video que se obtuvo
  Int  10h
  Mov  Ax,@Data             ; Inicializa DS con la direcci¢n de @Data
  Mov  Ds, Ax
  Mov  Dx, Offset Mensaje   ; Despliega el mensaje de bienvenida
  Call Imprime  
   
  Mov  Si, Offset ResultaR         ; Inicializa la variable ResultaR
  Add  Si, 11 
  
  Mov  Si, Offset ResultaR1         ; Inicializa la variable ResultaR1
  Add  Si, 11    
  
  Mov  Si, Offset ResultaR2         ; Inicializa la variable ResultaR2
  Add  Si, 11    
  
  Mov  Si, Offset ResultaR3         ; Inicializa la variable ResultaR3
  Add  Si, 11    
                          
  Mov  Si, Offset ResultaR4         ; Inicializa la variable ResultaR4
  Add  Si, 11      
  
  Mov  Si, Offset ResultaR5         ; Inicializa la variable ResultaR5
  Add  Si, 11 
            
  Mov  Al, '$'   
  Mov  [Si], Al





; CAPTURA PRIMER CANTIDAD. 
CAPCANT01:
  Mov  Dx, Offset CantUnoM  ; Mensaje de captura de cantidad 1
  Call Imprime
  Mov  Ah, 0Ah              ; Captura la cantidad (hasta 8 d¡gitos)
  Mov  Dx, Offset CantUnoN
  Int  21h
  Mov  ErrorCAP, 0          ; Supone que no hay errores y que se est 
  Mov  Cantidad, 0          ; operando sobre la cantidad 1.
  Call ConvNUM              ; Convierte cantidad 1 a binario
  Cmp  ErrorCAP, 1          ; ¨Hubo error?
  Jz   CAPCANT01            ; S¡, regresa a la captura
  Mov  CantUnoR, Bx         ; Guarda resultado de conversi¢n


; CAPTURA SEGUNDA CANTIDAD.
CAPCANT02:
  Mov  ErrorCAP, 0          ; Supone que no hay error
  Mov  Cantidad, 1          ; Indica a ConvNUM que es la segunda cantidad
  Mov  Dx, Offset CantDosM  ; Mensaje de captura de cantidad 2
  Call Imprime
  Mov  Ah, 0Ah              ; Captura la segunda cantidad
  Mov  Dx, Offset CantDosN
  Int  21h
  Call ConvNUM              ; Convierte cantidad 2 a binario
  Cmp  ErrorCAP, 1          ; ¨Hay error?
  Jz   CAPCANT02            ; S¡, regresa a capturar la cantidad
  Mov  CantDosR, Bx         ; Guarda conversi¢n de cantidad 2

                             
                             
; CAPTURA TERCERA CANTIDAD.  
CAPCANT03:
  Mov  Dx, Offset CantUnoM1  ; Mensaje de captura de cantidad 3
  Call Imprime
  Mov  Ah, 0Ah              ; Captura la cantidad (hasta 8 d¡gitos)
  Mov  Dx, Offset CantUnoN1
  Int  21h
  Mov  ErrorCAP, 0          ; Supone que no hay errores y que se est 
  Mov  Cantidad, 0          ; operando sobre la cantidad 3.
  Call ConvNUM1              ; Convierte cantidad 3 a binario
  Cmp  ErrorCAP, 1          ; ¨Hubo error?
  Jz   CAPCANT03            ; S¡, regresa a la captura
  Mov  CantUnoR1, Bx         ; Guarda resultado de conversi¢n


; CAPTURA CUARTA CANTIDAD. 
CAPCANT04:
  Mov  ErrorCAP, 0          ; Supone que no hay error
  Mov  Cantidad, 1          ; Indica a ConvNUM que es la segunda cantidad
  Mov  Dx, Offset CantDosM1  ; Mensaje de captura de cantidad 4
  Call Imprime
  Mov  Ah, 0Ah              ; Captura la segunda cantidad
  Mov  Dx, Offset CantDosN1
  Int  21h
  Call ConvNUM1              ; Convierte cantidad 4 a binario
  Cmp  ErrorCAP, 1          ; ¨Hay error?
  Jz   CAPCANT04            ; S¡, regresa a capturar la cantidad
  Mov  CantDosR1, Bx         ; Guarda conversi¢n de cantidad 4


; CAPTURA QUINTA CANTIDAD. 
CAPCANT05:
  Mov  Dx, Offset CantUnoM2  ; Mensaje de captura de cantidad 5
  Call Imprime
  Mov  Ah, 0Ah              ; Captura la cantidad (hasta 8 d¡gitos)
  Mov  Dx, Offset CantUnoN2
  Int  21h
  Mov  ErrorCAP, 0          ; Supone que no hay errores y que se est 
  Mov  Cantidad, 0          ; operando sobre la cantidad 5.
  Call ConvNUM2              ; Convierte cantidad 5 a binario
  Cmp  ErrorCAP, 1          ; ¨Hubo error?
  Jz   CAPCANT05            ; S¡, regresa a la captura
  Mov  CantUnoR2, Bx         ; Guarda resultado de conversi¢n


; CAPTURA SEXTA CANTIDAD.  
CAPCANT06:
  Mov  ErrorCAP, 0          ; Supone que no hay error
  Mov  Cantidad, 1          ; Indica a ConvNUM que es la segunda cantidad
  Mov  Dx, Offset CantDosM2  ; Mensaje de captura de cantidad 6
  Call Imprime
  Mov  Ah, 0Ah              ; Captura la segunda cantidad
  Mov  Dx, Offset CantDosN2
  Int  21h
  Call ConvNUM2              ; Convierte cantidad 6 a binario
  Cmp  ErrorCAP, 1          ; ¨Hay error?
  Jz   CAPCANT06            ; S¡, regresa a capturar la cantidad
  Mov  CantDosR2, Bx         ; Guarda conversi¢n de cantidad 6

  
                           
                           
; PROGRAMA                 
  
  Call Divide               ; Divide las dos cantidades
          
  Call Multiplica           ; Multiplica las dos cantidades     
    
  Call Suma                 ; Suma las dos cantidades  
  
  Call Resta                ; Resta las dos cantidades
     
  Call Suma1                 ; Suma las dos cantidades         
  
  Mov  Ax, 4C00h          ; Termina el programa sin errores.
  Int  21h




;____________________________________________________________

Divide Proc Near

  Mov  Ax, CantUnoR        ; Carga la cantidad 1 (dividendo)
  Mov  Bx, CantDosR        ; Carga la cantidad 2 (divisor)
  Cmp  Bx, 0               ; Revisa si el divisor es 0 para evitar un
  			                ; error de divisi¢n por cero.
  Jnz  DIVIDE01
  Mov  Cantidad, 3         ; Hubo error, as¡ que despliega el mensaje y
 			               ; salta
  Call HuboERROR
  Ret    
  
DIVIDE01:
  Div  Bx                  ; Divide
  Xor  Dx, Dx              ; Dx = 0. No se usa el residuo para simplificar
                           ; las operaciones                             
  Mov  CantUnoR4, Ax                           
  Call ConvASCII           ; Convierte en ASCII
  Mov  Dx, Offset Resulta  ; Despliega la cadena del resultado
  Call Imprime
  Mov  Dx, Offset ResultaR ; Despliega el resultado
  Call Imprime
  Ret
Divide Endp




;___________________________________________________________

Multiplica Proc Near
  Xor  Dx, Dx                   ; Dx = 0 por si acaso
  Mov  Ax, CantUnoR1            ; Primera cantidad (multiplicando)
  Mov  Bx, CantDosR1            ; Segunda cantidad (multiplicador)
  Mul  Bx                       ; Multiplica
  Mov  CantUnoR3, Ax 
  Call ConvASCII1                ; Convierte en ASCII 
  Mov  Dx, Offset Resulta1      ; Prepara para desplegar la cadena del resultado
  Mov  Dx, Offset ResultaR1      ; Despliega el resultado.            
  Call Imprime
  Ret
Multiplica Endp





;_______________________________________________________________

Suma Proc Near
  Xor  Dx, Dx               ; Dx = 0 por si acaso existe acarreo
  Mov  Ax, CantUnoR2         ; Primera cantidad
  Mov  Bx, CantDosR2        ; Segunda cantidad
  Add  Ax, Bx               ; suma
  Jnc  SUMACONV             ; ¨Hubo acarreo?
  Adc  Dx, 0                ; S¡.
  
  
SUMACONV: 

  Mov  CantDosR3, Ax
  Call ConvASCII2            ; Convierte resultado en ASCII     
  Mov  Dx, Offset Resulta2   ; Despliega cadena del resultado
  Mov  Dx, Offset ResultaR2  ; Despliega el resultado  
  Call Imprime  
  Ret
Suma Endp

;____________________________________________________________

Resta Proc Near
  Xor  Dx, Dx               ; Dx = 0 por si acaso existe acarreo
  Mov  Ax, CantUnoR3        ; Primera cantidad   
  Mov  Bx, CantDosR3        ; Segunda cantidad
  Sub  Ax, Bx               ; Resta cantidades
  Jnc  RESTACONV            ; ¨Hubo acarreo?
  Sbb  Dx, 0                ; S¡.
RESTACONV:  
  Mov  CantDosR4, Ax
  Call ConvASCII3            ; Convierte en ASCII
  Mov  Dx, Offset Resulta3   ; Despliega cadena del resultado
  Mov  Dx, Offset ResultaR3  ; Despliega el resultado
  Call Imprime
  Ret
Resta Endp  

;____________________________________________________________

Suma1 Proc Near
  Xor  Dx, Dx               ; Dx = 0 por si acaso existe acarreo
  Mov  Ax, CantUnoR4         ; Primera cantidad
  Mov  Bx, CantDosR4        ; Segunda cantidad
  Add  Ax, Bx               ; suma
  Jnc  SUMACONV1             ; ¨Hubo acarreo?
  Adc  Dx, 0                ; S¡.    
  
SUMACONV1: 
  
  Call ConvASCII4            ; Convierte resultado en ASCII     
  Mov  Dx, Offset Resulta4   ; Despliega cadena del resultado
  Mov  Dx, Offset ResultaR4  ; Despliega el resultado  
  Call Imprime  
  Ret
Suma1 Endp


;------------------------------------------------------------------------------


Imprime Proc Near
  Mov  Ah, 9               ; Prepara para desplegar la cadena a trav‚s de la
  Int  21h                 ; INT 21h.
  Ret
Imprime Endp        



;------------------------------------------------------------------------------


;ObtenTecla Proc Near
  Mov  Ah, 0               ; Lee una tecla del teclado a trav‚s de la INT 16h
  Int  16h
  Ret
;ObtenTecla Endp    

                    
                    
                    
;------------------------------------------------------------------------------


ConvNUM Proc Near
  Mov  Dx, 0Ah                   ; Multiplicador es 10
  Cmp  Cantidad, 0               ; ¨Es la cantidad 1?
  Jnz  CONVNUM01                 ; NO, as¡ que es la cantidad 2
  Mov  Di, Offset CantUnoN + 1   ; Bytes le¡dos de la cantidad 1
  Mov  Cx, [Di]
  Mov  Si, Offset CantUnoN + 2   ; La cantidad 1
  Jmp  CONVNUM02

CONVNUM01:
  Mov  Di, Offset CantDosN + 1   ; Bytes le¡dos de la cantidad 2
  Mov  Cx, [Di]
  Mov  Si, Offset CantDosN + 2   ; La cantidad 2

CONVNUM02:
  Xor  Ch, Ch                    ; CH = 0
  Mov  Di, Offset Potencia       ; Direcci¢n de la tabla de potencias
  Dec  Si                        ; Posiciona Si en el primer byte de la
  Add  Si, Cx                    ; cadena capturada y le suma el
  Xor  Bx, Bx                    ; desplazamiento de bytes le¡dos
  Std                            ; para que podamos posicionarnos en el
                                 ; final de la misma (apunta al £ltimo
                                 ; d¡gito capturado). BX = 0 y lee la 
                                 ; cadena en forma inversa; es decir, de
                                 ; atr s hacia adelante.  
                                 

CONVNUM03:  
  Lodsb                 ; Levanta un byte del n£mero (esta instrucci¢n indica
                        ; que el registro AL ser  cargado con el contenido
                        ; de la direcci¢n apuntada por DS:SI.
  Cmp  AL,"0"           ; ¨Es menor a 0? (entonces NO es un d¡gito v lido)
  Jb   CONVNUM04        ; S¡, despliega el mensaje de error y termina
  Cmp  AL,"9"           ; ¨Es mayor a 9? (entonces NO es un d¡gito v lido)
  Ja   CONVNUM04        ; S¡, despliega el error y salta
  Sub  Al, 30h          ; Convierte el d¡gito de ASCII a binario
  Cbw                   ; Convierte a palabra
  Mov  Dx, [Di]         ; Obtiene la potencia de 10 que ser  usada para
  Mul  Dx               ; multiplicar, multiplica n£mero y lo suma
  Jc   CONVNUM05        ; a BX. Revisa si hubo acarreo, y si lo hubo, esto
  Add  Bx, Ax           ; significa que la cantidad es > 65535.
  Jc   CONVNUM05        ; Si hay acarreo la cantidad es > 65535
  Add  Di, 2            ; Va a la siguiente potencia de 10
  Loop CONVNUM03        ; Itera hasta que CX sea = 0
  Jmp  CONVNUM06

CONVNUM04:
  Call HuboERROR        ; Algo ocurri¢, despliega mensaje y salta
  Jmp  CONVNUM06

CONVNUM05:
  Mov  Cantidad, 2      ; Hubo acarreo en la conversi¢n, por lo tanto la
  Call HuboERROR        ; cantidad capturada es mayor a 65535.

CONVNUM06:
  Cld                   ; Regresa la bandera de direcci¢n a su estado normal
  Ret                   ; y REGRESA. 
  
  
ConvNum Endp  
  
  
  
;__________________   

  
ConvNUM1 Proc Near    

  Mov  Dx, 0Ah                   
  Cmp  Cantidad, 0               
  Jnz  CONVNUM11                 
  Mov  Di, Offset CantUnoN1 + 1  
  Mov  Cx, [Di]
  Mov  Si, Offset CantUnoN1 + 2  
  Jmp  CONVNUM12

CONVNUM11:
  Mov  Di, Offset CantDosN1 + 1  
  Mov  Cx, [Di]
  Mov  Si, Offset CantDosN1 + 2  
  
  
CONVNUM12:
  Xor  Ch, Ch                    
  Mov  Di, Offset Potencia       
  Dec  Si                        
  Add  Si, Cx                    
  Xor  Bx, Bx                    
  Std                            
                                 
                                  
;________                                 

CONVNUM13:     


  Lodsb                 
  Cmp  AL,"0"           
  Jb   CONVNUM14        
  Cmp  AL,"9"           
  Ja   CONVNUM14        
  Sub  Al, 30h          
  Cbw                   
  Mov  Dx, [Di]         
  Mul  Dx               
  Jc   CONVNUM15        
  Add  Bx, Ax           
  Jc   CONVNUM15        
  Add  Di, 2            
  Loop CONVNUM13        
  Jmp  CONVNUM16

CONVNUM14:
  Call HuboERROR        
  Jmp  CONVNUM16

CONVNUM15:
  Mov  Cantidad, 2      
  Call HuboERROR        

CONVNUM16:
  Cld                   
  Ret           
  
  

ConvNum1 Endp  
 
 
;________ 
 
 
ConvNUM2 Proc Near 

  Mov  Dx, 0Ah                   
  Cmp  Cantidad, 0               
  Jnz  CONVNUM21                 
  Mov  Di, Offset CantUnoN2 + 1   
  Mov  Cx, [Di]
  Mov  Si, Offset CantUnoN2 + 2   
  Jmp  CONVNUM22

CONVNUM21:
  Mov  Di, Offset CantDosN2 + 1   
  Mov  Cx, [Di]
  Mov  Si, Offset CantDosN2 + 2   

CONVNUM22:
  Xor  Ch, Ch                    
  Mov  Di, Offset Potencia       
  Dec  Si                        
  Add  Si, Cx                    
  Xor  Bx, Bx                    
  Std                            
                                 
                                  
;___________                                 
                                 

CONVNUM23:
  Lodsb              
                        
  Cmp  AL,"0"           
  Jb   CONVNUM24        
  Cmp  AL,"9"           
  Ja   CONVNUM24        
  Sub  Al, 30h          
  Cbw                   
  Mov  Dx, [Di]         
  Mul  Dx               
  Jc   CONVNUM25        
  Add  Bx, Ax           
  Jc   CONVNUM25        
  Add  Di, 2            
  Loop CONVNUM23        
  Jmp  CONVNUM26

CONVNUM24:
  Call HuboERROR        
  Jmp  CONVNUM26

CONVNUM25:
  Mov  Cantidad, 2      
  Call HuboERROR        

CONVNUM26:
  Cld                   
  Ret                     
  

ConvNum2 Endp     




;______________________________________


ConvASCII Proc Near   

  Push Dx
  Push Ax                  ; Guarda el resultado
  Mov  Si, Offset ResultaR ; Inicializa la variable ResultaR llen ndola
  Mov  Cx, 10              ; con asteriscos
  Mov  Al, '*'

ConvASCII01:
  Mov  [Si], Al
  Inc  Si
  Loop ConvASCII01
  Pop  Ax
  Pop  Dx
  Mov  Bx, Ax                  ; Palabra baja de la cantidad
  Mov  Ax, Dx                  ; Palabra alta de la cantidad
  Mov  Si,Offset ResultaR      ; Cadena donde se guardar  el resultado
  Add  Si, 11
  Mov  CX, 10                  ; Divisor = 10

OBTENDIGITO:
  Dec  Si
  Xor  Dx, Dx                  ; DX contendr  el residuo
  Div  Cx                      ; Divide la palabra alta (AX)
  Mov  Di, Ax                  ; Guarda cociente (AX)
  Mov  Ax, Bx                  ; AX = palabra baja (BX)
  Div  Cx                      ; DX ten¡a un residuo de la divisi¢n anterior
  Mov  Bx, Ax                  ; Guarda el cociente
  Mov  Ax, Di                  ; Regresa la palabra alta
  Add  Dl,30h                  ; Convierte residuo en ASCII
  Mov  [Si], Dl                ; Lo almacena
  Or   Ax, Ax                  ; ¨Palabra alta es 0?
  Jnz  OBTENDIGITO             ; No, sigue procesando
  Or   Bx, Bx                  ; ¨Palabra baja es 0?
  Jnz  OBTENDIGITO             ; No, sigue procesando
  Ret   
  
ConvASCII Endp   



  
  
ConvASCII1 Proc Near  
  Push Dx
  Push Ax                   ; Guarda el resultado
  Mov  Si, Offset ResultaR1 ; Inicializa la variable ResultaR llen ndola
  Mov  Cx, 10               ; con asteriscos
  Mov  Al, '*'

ConvASCII11:
  Mov  [Si], Al
  Inc  Si
  Loop ConvASCII11
  Pop  Ax
  Pop  Dx
  Mov  Bx, Ax                  ; Palabra baja de la cantidad
  Mov  Ax, Dx                  ; Palabra alta de la cantidad
  Mov  Si,Offset ResultaR1      ; Cadena donde se guardar  el resultado
  Add  Si, 11
  Mov  CX, 10                  ; Divisor = 10

OBTENDIGITO1:
  Dec  Si
  Xor  Dx, Dx                  ; DX contendr  el residuo
  Div  Cx                      ; Divide la palabra alta (AX)
  Mov  Di, Ax                  ; Guarda cociente (AX)
  Mov  Ax, Bx                  ; AX = palabra baja (BX)
  Div  Cx                      ; DX ten¡a un residuo de la divisi¢n anterior
  Mov  Bx, Ax                  ; Guarda el cociente
  Mov  Ax, Di                  ; Regresa la palabra alta
  Add  Dl,30h                  ; Convierte residuo en ASCII
  Mov  [Si], Dl                ; Lo almacena
  Or   Ax, Ax                  ; ¨Palabra alta es 0?
  Jnz  OBTENDIGITO1            ; No, sigue procesando
  Or   Bx, Bx                  ; ¨Palabra baja es 0?
  Jnz  OBTENDIGITO1            ; No, sigue procesando
  Ret                                                  

ConvASCII1 Endp  



  
ConvASCII2 Proc Near  
  Push Dx
  Push Ax                  ; Guarda el resultado
  Mov  Si, Offset ResultaR2 ; Inicializa la variable ResultaR llen ndola
  Mov  Cx, 10              ; con asteriscos
  Mov  Al, '*'

ConvASCII21:
  Mov  [Si], Al
  Inc  Si
  Loop ConvASCII21
  Pop  Ax
  Pop  Dx
  Mov  Bx, Ax                  ; Palabra baja de la cantidad
  Mov  Ax, Dx                  ; Palabra alta de la cantidad
  Mov  Si,Offset ResultaR2      ; Cadena donde se guardar  el resultado
  Add  Si, 11
  Mov  CX, 10                  ; Divisor = 10

OBTENDIGITO2:
  Dec  Si
  Xor  Dx, Dx                  ; DX contendr  el residuo
  Div  Cx                      ; Divide la palabra alta (AX)
  Mov  Di, Ax                  ; Guarda cociente (AX)
  Mov  Ax, Bx                  ; AX = palabra baja (BX)
  Div  Cx                      ; DX ten¡a un residuo de la divisi¢n anterior
  Mov  Bx, Ax                  ; Guarda el cociente
  Mov  Ax, Di                  ; Regresa la palabra alta
  Add  Dl,30h                  ; Convierte residuo en ASCII
  Mov  [Si], Dl                ; Lo almacena
  Or   Ax, Ax                  ; ¨Palabra alta es 0?
  Jnz  OBTENDIGITO2             ; No, sigue procesando
  Or   Bx, Bx                  ; ¨Palabra baja es 0?
  Jnz  OBTENDIGITO2             ; No, sigue procesando
  Ret  

ConvASCII2 Endp      



  
  
ConvASCII3 Proc Near  
  Push Dx
  Push Ax                       ; Guarda el resultado
  Mov  Si, Offset ResultaR3     ; Inicializa la variable ResultaR llen ndola
  Mov  Cx, 10                   ; con asteriscos
  Mov  Al, '*'

ConvASCII31:
  Mov  [Si], Al
  Inc  Si
  Loop ConvASCII31
  Pop  Ax
  Pop  Dx
  Mov  Bx, Ax                  ; Palabra baja de la cantidad
  Mov  Ax, Dx                  ; Palabra alta de la cantidad
  Mov  Si,Offset ResultaR3      ; Cadena donde se guardar  el resultado
  Add  Si, 11
  Mov  CX, 10                  ; Divisor = 10

OBTENDIGITO3:
  Dec  Si
  Xor  Dx, Dx                  ; DX contendr  el residuo
  Div  Cx                      ; Divide la palabra alta (AX)
  Mov  Di, Ax                  ; Guarda cociente (AX)
  Mov  Ax, Bx                  ; AX = palabra baja (BX)
  Div  Cx                      ; DX ten¡a un residuo de la divisi¢n anterior
  Mov  Bx, Ax                  ; Guarda el cociente
  Mov  Ax, Di                  ; Regresa la palabra alta
  Add  Dl,30h                  ; Convierte residuo en ASCII
  Mov  [Si], Dl                ; Lo almacena
  Or   Ax, Ax                  ; ¨Palabra alta es 0?
  Jnz  OBTENDIGITO3             ; No, sigue procesando
  Or   Bx, Bx                  ; ¨Palabra baja es 0?
  Jnz  OBTENDIGITO3             ; No, sigue procesando
  Ret  

ConvASCII3 Endp 




ConvASCII4 Proc Near  
  Push Dx
  Push Ax                  ; Guarda el resultado
  Mov  Si, Offset ResultaR4 ; Inicializa la variable ResultaR llen ndola
  Mov  Cx, 10              ; con asteriscos
  Mov  Al, '*'

ConvASCII41:
  Mov  [Si], Al
  Inc  Si
  Loop ConvASCII41
  Pop  Ax
  Pop  Dx
  Mov  Bx, Ax                  ; Palabra baja de la cantidad
  Mov  Ax, Dx                  ; Palabra alta de la cantidad
  Mov  Si,Offset ResultaR4      ; Cadena donde se guardar  el resultado
  Add  Si, 11
  Mov  CX, 10                  ; Divisor = 10

OBTENDIGITO4:
  Dec  Si
  Xor  Dx, Dx                  ; DX contendr  el residuo
  Div  Cx                      ; Divide la palabra alta (AX)
  Mov  Di, Ax                  ; Guarda cociente (AX)
  Mov  Ax, Bx                  ; AX = palabra baja (BX)
  Div  Cx                      ; DX ten¡a un residuo de la divisi¢n anterior
  Mov  Bx, Ax                  ; Guarda el cociente
  Mov  Ax, Di                  ; Regresa la palabra alta
  Add  Dl,30h                  ; Convierte residuo en ASCII
  Mov  [Si], Dl                ; Lo almacena
  Or   Ax, Ax                  ; ¨Palabra alta es 0?
  Jnz  OBTENDIGITO4             ; No, sigue procesando
  Or   Bx, Bx                  ; ¨Palabra baja es 0?
  Jnz  OBTENDIGITO4             ; No, sigue procesando
  Ret  

ConvASCII4 Endp      


;------------------------------------------------------------------------------


HuboERROR  Proc Near

  Cmp  Cantidad, 0        ; ¨Es la cantidad 1?
  Jnz  HUBOERROR02        ; No.
  Mov  Dx, Offset Error1
  Call Imprime
  Mov  ErrorCAP, 1        ; Enciende la bandera de error
  Jmp  HUBOERROR05

HUBOERROR02:
  Cmp  Cantidad, 1        ; ¨Es la cantidad 2?
  Jnz  HUBOERROR03        ; No.
  Mov  Dx, Offset Error2
  Call Imprime
  Mov  ErrorCAP, 1
  Jmp  HUBOERROR05

HUBOERROR03:
  Cmp  Cantidad, 2        ; ¨Cantidad capturada est  fuera de rango ?
  Jnz  HUBOERROR04        ; No.
  Mov  Dx, Offset Error3
  Call Imprime
  Mov  ErrorCAP, 1
  Jmp  HUBOERROR05

HUBOERROR04:
  Mov  Dx, Offset Error4  ; Error de intento de divisi¢n por cero
  Call Imprime
  Mov  ErrorCAP, 1

HUBOERROR05:
  Ret

HuboERROR Endp   


  .STACK
  
  End  Empieza