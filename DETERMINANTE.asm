.MODEL SMALL
    ORG 0100H 

.DATA
    ARREGLO_1   DB  9  DUP (?)
    RESULTADO   DB  9  DUP (?) 
    MENSAJE_1   DB  'MATRIZ 1','$'
    MENSAJE_3   DB  'RESULTADO DETERMINANTE=','$' 
    
    
    


.CODE
    ; Inicializar DS
    START:  MOV AX, @DATA
            MOV DS, AX
;---------------------------------------            
            ; LEER DATO DEL TECLADO
            MOV BX,OFFSET ARREGLO_1
            MOV CX,3 
            CALL    MENSAJE_M_1
       INICIO:
            
            PUSH    CX     
            MOV CX,3                 ;NUMERO DE DATOS QUE SE LEEN
       LEER_TECLADO: 
            
            MOV AH, 01H              ;FUNCION 1 DE LA INTERRUPCION 21H
            INT 21H   
            MOV [BX],AL              ;CARGA LO LEIDO DEL TECLADO EN LA DIRECCION APUNTADA POR BX
            INC BX
            LOOP LEER_TECLADO 
            
            POP CX
            CALL    ENTER_RET 
            LOOP    INICIO    
            CALL    MENSAJE_M_3       ;MUESTRA MENSAJE DE INICIO
;----------------------------------------            
            
            MOV BX,OFFSET   ARREGLO_1   ;CARAGA EN BX LA DIRECCION DEL ARREGLO_1
            MOV DI,OFFSET   RESULTADO   ;CARGA EN DI LA DIRECCIO DE RESULTADO DONDE SE ALMACENARAN LOS VALORES INTERMEDIOS DE RESULTADOS
       OPERACION:
            ADD BX,4              ;UBICA LA POSICION DE LA MATRIZ DEL PRIMER VALOR
            MOV AL,[BX]           ;CARGA  AL  EL VALOR UBICADO EN LA MATRIZ POR BX
            SUB AL,30H            ;ascii
            ADD BX,4              ;CAMBIA LA POSICION DE LA MATRIZ
            MOV DL,[BX]           ;CARGA EN DL, LO AUNTADO POR EL BX EN LA MATRIZ
            SUB DL,30H
            MUL DL                ;LA MULTIPLICACION GUARDA EL DATO EN AL  ENTRE AL Y DL
            
            MOV [DI],AL           ;GUARDA EN 'RESULTADO' EL VALOR DE LA MULTIPLICACION
            INC DI
            
            SUB BX,3              ;CAMBIA LA POSCION QUE SE APUNTA EN LA MTRIZ
            MOV DL,[BX]           ;CARGA EN DL, LO AUNTADO POR EL BX EN LA MATRIZ
            SUB DL,30H
            ADD BX,2              ;CAMBIA LA POSCION QUE SE APUNTA EN LA MTRIZ
            MOV AL,[BX]           ;CARGA  AL  EL VALOR UBICADO EN LA MATRIZ POR BX
            SUB AL,30H
            MUL DL                ;LA MULTIPLICACION GUARDA EL DATO EN AL  ENTRE AL Y DL
                   
            
            MOV [DI],AL           ;GUARDA EN 'RESULTADO' EL VALOR DE LA MULTIPLICACION
            INC DI
            
            MOV DI,OFFSET   RESULTADO
            MOV BX,OFFSET   ARREGLO_1
            MOV AL,[DI]           ;TOMA EL PRIMER DATO GUARDADO EN 'RESULTADO' DE OPERACION MULTIPLICAR
            INC DI
            MOV AH,[DI]           ;TOMA EL SEGUNDOI DATO GUARDADO EN 'RESULTADO' DE OPERACION MULTIPLICAR
            SUB AL,AH             ;RESTA LOS VALORES DE LA MULTIPLICACION
            MOV DL,[BX]
            SUB DL,30H
            MUL DL                ;MULTIPLICA CON EL VALOR APUNTADO POR EL BX SE GUARDA EN AL
            MOV DI,OFFSET   RESULTADO  
            
            ADD DI,2 
            MOV [DI],AL          ;RESULTADO DE PRIMERA OPERACION (PUEDE SER NEGATIVO)
            INC DI
            
            ADD BX,3
            MOV AL,[BX]
            SUB AL,30H
            ADD BX,5
            MOV DL,[BX]
            SUB DL,30H
            MUL DL
                
            MOV [DI],AL
            INC DI
            
            SUB BX,3
            MOV DL,[BX]
            SUB DL,30H
            ADD BX,1
            MOV AL,[BX]
            SUB AL,30H
            MUL DL
            
            MOV [DI],AL
            
            MOV DI,OFFSET   RESULTADO
            ADD DI,3
            MOV AL,[DI]
            ADD DI,1
            MOV AH,[DI]
            SUB AL,AH
            SUB BX,5
            MOV DL,[BX]
            SUB DL,30H
            MUL DL
            
            INC DI
            MOV [DI],AL         ;RESULTADO DE LA SEGUNDA OPERACION ESTA EN REGISTROS AH Y AL
            INC DI
            
            ADD BX,2
            MOV AL,[BX]
            SUB AL,30H
            ADD BX,4
            MOV DL,[BX]
            SUB DL,30H
            MUL DL
            
            MOV [DI],AL
            INC DI
            
            SUB BX,3
            MOV DL,[BX]
            SUB DL,30H
            ADD BX,2
            MOV AL,[BX]
            SUB AL,30H
            MUL DL
            
            MOV [DI],AL
            
            SUB DI,1
            MOV AL,[DI]
            ADD DI,1
            MOV AH,[DI]
            SUB AL,AH
            SUB BX,4
            MOV DL,[BX]
            SUB DL,30H
            MUL DL
            
            
            INC DI
            MOV [DI],AL    ;RESULTADO TERCERA OPERACION
            
            MOV DI,OFFSET   RESULTADO
            ADD DI,2
            MOV AL,[DI]
            ADD DI,3
            MOV AH,[DI]
            SUB AL,AH       ;RESTA 1
            ADD DI,3
            MOV DL,[DI]
            ADD AL,DL   
            
            CALL    BIN_BCD      
            
            JMP EXIT
;--------------------------------
                   
;---------------------------------
      BIN_BCD PROC NEAR             ;ESTA RUTINA RETORNA LOS VALORES EN  BH(CENTENA),DH(DECENA),BL(UNIDADES)
            PUSH    CX
            PUSH    DX              ;SE GUARDAN LOS REGISTROS PARA QUE NO SE MODIFIQUEN
            PUSH    BX
            PUSH    AX
            SUB     BX,BX           ;SE HACEN 0 LOS REGISTROS BX Y DX
            SUB     DX,DX
            
            MOV     BL,AL
            MOV     CX,BX           ;EL VALOR DE BX SE CARGA A CX, EL CUAL SERA EL CONTADOR 
            SUB     BX,BX           ;SE HACEN 0 LOS REGISTROS BX Y DX
               
      RESTA:
            ADD     BL,01H 
            CMP     BL,11           ;PREGUNTAMOS SI EL VALOR ES MAYOR O IGUAL A 11
            JAE     RESTA_MAS       ;SI ES MAYOR O IGUAL SALTA A LA RUTINA
            LOOP    RESTA
            
            CALL    MOSTRAR              
               
            POP     AX              ;SE RETORNAN LOS VALORES DE LOS REGISTROS
            POP     BX
            POP     DX
            POP     CX
            RET   
            
      RESTA_MAS:
            INC     DH
            SUB     BL,BL 
            CMP     DH,11
            JAE     RESTA_MAS_MAS
            JMP     RESTA        
            
      RESTA_MAS_MAS:
            INC     BH
            SUB     BL,BL
            SUB     DH,DH
            JMP     RESTA_MAS      
            RET
      BIN_BCD ENDP       
       
       
;---------------------------------       
;---------------------------------
      MOSTRAR  PROC NEAR  
            PUSH    CX
            PUSH    DX
            PUSH    BX
            PUSH    AX          ;SE UTILIZA LA FUNCION 02H DE LA INTERRUPCION 21 PARA MOSTRAR
            MOV     AH,2        ; POR PANTALLA LOS DATOS 
            MOV     DL,BH
            ADD     DL,30H
            INT     21H
            MOV     AH,2
            MOV     DL,DH
            ADD     DL,30H
            INT     21H
            MOV     AH,2
            MOV     DL,BL
            ADD     DL,30H      ;SE SUMA 30 AL DATO DE ENTRADA PARA OBTENER EL VALOR EN ASCII
            INT     21H   
            MOV     AH,2
            MOV     DL,32       ;SALTO DE LINEA   
            INT     21H  
            POP     AX
            POP     BX
            POP     DX
            POP     CX
            RET
      MOSTRAR ENDP  

;---------------------------------
;---------------------------------       
       MENSAJE_M_1 PROC     NEAR        ;RUTINA PARA MOSTRAR MENSAJE 1 (MATRIZ 1)
            MOV DX,OFFSET MENSAJE_1     
            MOV AH,09H
            INT 21H
            CALL    ENTER_RET          
                      
            RET               
       MENSAJE_M_1  ENDP   
       
      
       
       MENSAJE_M_3  PROC    NEAR        ;RUTINA PARA MOSTRAR MENSAJE 3 (RESULTADO DETERMINANTE)
            MOV DX,OFFSET MENSAJE_3
            MOV AH,09H
            INT 21H
            CALL    ENTER_RET
            
            RET
       MENSAJE_M_3  ENDP 
       
    ;///////////////////////////////////////////////////////////////////////////////   
                         
       ENTER_RET    PROC    NEAR        ;RUTINA QUE GENERA ENTER 
            MOV AH,2
            MOV DL,10
            INT 21H
            MOV AH,2
            MOV DL,13
            INT 21H
            RET
       ENTER_RET    ENDP                     
           
            ; Retorno al Sistema Operativo
       EXIT:     
            MOV AX, 4C00H
            INT 21H     
            
    END START 
       
.STACK
      

END