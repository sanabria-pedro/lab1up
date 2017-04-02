.MODEL SMALL
include "emu8086.inc"
    ORG 0100H 

.DATA
    ARREGLO_1   DB  16  DUP (?)
    ARREGLO_2   DB  16  DUP (?)
    RESULTADO   DB  16  DUP (?)
    MENSAJE_1   DB  'MATRIZ 1','$'
    MENSAJE_2   DB  'MATRIZ 2','$'
    MENSAJE_3   DB  'RESULTADO SUMA =','$' 
    MENSAJE_4   DB  'RESULTADO MULTIPLICACION=','$'
    var_1 db ?
    var_2 db ?
    var_3 db ?
    var_4 db ?

    DEFINE_SCAN_NUM
    DEFINE_PRINT_STRING
    DEFINE_PRINT_NUM
    DEFINE_PRINT_NUM_UNS
    DEFINE_PTHIS 


.CODE
    ; Inicializar DS
    START:  MOV AX, @DATA
            MOV DS, AX
;---------------------------------------            
            ; LEER DATO DEL TECLADO
            MOV BX,OFFSET ARREGLO_1
            MOV CX,4 
            CALL    MENSAJE_M_1
       INICIO:
            
            PUSH    CX     
            MOV CX,4                 ;NUMERO DE DATOS QUE SE LEEN
       LEER_TECLADO: 
            
            MOV AH, 01H              ;FUNCION 1 DE LA INTERRUPCION 21H
            INT 21H
            sub AL,30H  
            MOV [BX],AL              ;CARGA LO LEIDO DEL TECALDO EN LA DIRECCION APIUNTADA POR BX
            INC BX
            LOOP LEER_TECLADO 
            
            POP CX
            CALL    ENTER_RET 
            LOOP    INICIO
;----------------------------------------            
            ;LEER DATO DEL TECLADO 2
            MOV BX,OFFSET ARREGLO_2
            MOV CX,4
            CALL    MENSAJE_M_2
       INICIO_2:
            PUSH    CX
            MOV CX,4
       LEER_TECLADO_2:
            MOV AH, 01H              ;FUNCION 1 DE LA INTERRUPCION 21H
            INT 21H
            sub AL,30H   
            MOV [BX],AL               ;CARGA LO LEIDO DEL TECALDO EN LA DIRECCION APIUNTADA POR BX
            INC BX
            LOOP LEER_TECLADO_2 
            
            POP CX
            CALL    ENTER_RET 
            LOOP    INICIO_2   
            
            ;;///**************************************************************************************************
     suma proc NEAR 
        CALL    MENSAJE_M_3
            mov ax,0
            mov bx,0
            mov si,0 
            mov cx,0
        suma1:
        mov al,ARREGLO_1[si]
        add al,ARREGLO_2[si]  
        
        mov RESULTADO[si],al
        
        inc si
        inc bx
        cmp bx,16
        jne suma1
        mov bx,0
        mov si,0
         
        impresionsuma:
        print " "
        mov al,RESULTADO[si] 
        call print_num
        inc si
        inc bx
        cmp bx,4 
        jne impresionsuma
        printn " "
        jmp impresionsuma1 
        ;imprime fila2 
        
        
        impresionsuma1:
        print " "
        mov al,RESULTADO[si] 
        call print_num
        inc si
        inc bx
        cmp bx,8 
        jne impresionsuma1
        printn " "
        jmp impresionsuma2 
        ;imprime fila3 
        
        
        impresionsuma2:
        print " "
        mov al,RESULTADO[si] 
        call print_num
        inc si
        inc bx
        cmp bx,12 
        jne impresionsuma2
        printn " " 
        jmp impresionsuma3 
        ;imprime fila4
        
        
        impresionsuma3:
        print " "
        mov al,RESULTADO[si] 
        call print_num
        inc si
        inc bx
        cmp bx,16 
        jne impresionsuma3 
          printn " "
        mov cx,0
        mov bx,0
        mov si,0     
     suma endp
     
     
        CALL    MENSAJE_M_4
        
    multiplicacion proc
      multiplicacion1:
      
      mov al,ARREGLO_1[0]
      mov bl,ARREGLO_2[0] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[1]
      mov bl,ARREGLO_2[4] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[2]
      mov bl,ARREGLO_2[8] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[3]
      mov bl,ARREGLO_2[12] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[0],al 
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0
       MOV AX,0 
      MOV BX,0
      ;--------------------------
      mov al,ARREGLO_1[0]
      mov bl,ARREGLO_2[1] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[1]
      mov bl,ARREGLO_2[5] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[2]
      mov bl,ARREGLO_2[9] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[3]
      mov bl,ARREGLO_2[13] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[1],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0 
       MOV AX,0 
      MOV BX,0
         ;--------------------------
      mov al,ARREGLO_1[0]
      mov bl,ARREGLO_2[2] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[1]
      mov bl,ARREGLO_2[6] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[2]
      mov bl,ARREGLO_2[10] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[3]
      mov bl,ARREGLO_2[14] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[2],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0 
       MOV AX,0 
      MOV BX,0  
            ;--------------------------
      mov al,ARREGLO_1[0]
      mov bl,ARREGLO_2[3] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[1]
      mov bl,ARREGLO_2[7] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[2]
      mov bl,ARREGLO_2[11] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[3]
      mov bl,ARREGLO_2[15] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0 
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[3],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0  
      
       MOV AX,0 
      MOV BX,0
         
        ;-------------------fila2    
        
      mov al,ARREGLO_1[4]
      mov bl,ARREGLO_2[0] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[5]
      mov bl,ARREGLO_2[4] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[6]
      mov bl,ARREGLO_2[8] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[7]
      mov bl,ARREGLO_2[12] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[4],al 
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0
       MOV AX,0 
      MOV BX,0
      ;--------------------------
      mov al,ARREGLO_1[4]
      mov bl,ARREGLO_2[1] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[5]
      mov bl,ARREGLO_2[5] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[6]
      mov bl,ARREGLO_2[9] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[7]
      mov bl,ARREGLO_2[13] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[5],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0 
       MOV AX,0 
      MOV BX,0
         ;--------------------------
      mov al,ARREGLO_1[4]
      mov bl,ARREGLO_2[2] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[5]
      mov bl,ARREGLO_2[6] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[6]
      mov bl,ARREGLO_2[10] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[7]
      mov bl,ARREGLO_2[14] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[6],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0 
       MOV AX,0 
      MOV BX,0  
            ;--------------------------
      mov al,ARREGLO_1[4]
      mov bl,ARREGLO_2[3] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[5]
      mov bl,ARREGLO_2[7] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[6]
      mov bl,ARREGLO_2[11] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[7]
      mov bl,ARREGLO_2[15] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0 
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[7],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0  
      
       MOV AX,0 
      MOV BX,0 
         
             ;-------------------fila3    
        
      mov al,ARREGLO_1[8]
      mov bl,ARREGLO_2[0] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[9]
      mov bl,ARREGLO_2[4] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[10]
      mov bl,ARREGLO_2[8] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[11]
      mov bl,ARREGLO_2[12] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[8],al 
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0
       MOV AX,0 
      MOV BX,0
      ;--------------------------
      mov al,ARREGLO_1[8]
      mov bl,ARREGLO_2[1] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[9]
      mov bl,ARREGLO_2[5] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[10]
      mov bl,ARREGLO_2[9] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[11]
      mov bl,ARREGLO_2[13] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[9],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0 
       MOV AX,0 
      MOV BX,0
         ;--------------------------
      mov al,ARREGLO_1[8]
      mov bl,ARREGLO_2[2] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[9]
      mov bl,ARREGLO_2[6] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[10]
      mov bl,ARREGLO_2[10] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[11]
      mov bl,ARREGLO_2[14] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[10],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0 
       MOV AX,0 
      MOV BX,0  
            ;--------------------------
      mov al,ARREGLO_1[8]
      mov bl,ARREGLO_2[3] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[9]
      mov bl,ARREGLO_2[7] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[10]
      mov bl,ARREGLO_2[11] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[11]
      mov bl,ARREGLO_2[15] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0 
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[11],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0  
      
       MOV AX,0 
      MOV BX,0 
       
       
                  ;-------------------fila4    
        
      mov al,ARREGLO_1[12]
      mov bl,ARREGLO_2[0] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[13]
      mov bl,ARREGLO_2[4] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[14]
      mov bl,ARREGLO_2[8] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[15]
      mov bl,ARREGLO_2[12] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[12],al 
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0
       MOV AX,0 
      MOV BX,0
      ;--------------------------
      mov al,ARREGLO_1[12]
      mov bl,ARREGLO_2[1] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[13]
      mov bl,ARREGLO_2[5] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[14]
      mov bl,ARREGLO_2[9] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[15]
      mov bl,ARREGLO_2[13] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[13],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0 
       MOV AX,0 
      MOV BX,0
         ;--------------------------
      mov al,ARREGLO_1[12]
      mov bl,ARREGLO_2[2] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[13]
      mov bl,ARREGLO_2[6] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[14]
      mov bl,ARREGLO_2[10] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[15]
      mov bl,ARREGLO_2[14] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[14],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0 
       MOV AX,0 
      MOV BX,0  
            ;--------------------------
      mov al,ARREGLO_1[12]
      mov bl,ARREGLO_2[3] 
      mul bl
      MOV VAR_1,al
      mov al,ARREGLO_1[13]
      mov bl,ARREGLO_2[7] 
      mul bl
      MOV VAR_2,al
      mov al,ARREGLO_1[14]
      mov bl,ARREGLO_2[11] 
      mul bl
      MOV VAR_3,al
      mov al,ARREGLO_1[15]
      mov bl,ARREGLO_2[15] 
      mul bl
      MOV VAR_4,al 
      MOV AX,0 
      MOV BX,0
      add al,VAR_1
      add al,VAR_2
      add al,VAR_3
      add al,VAR_4
      mov RESULTADO[15],al
      
      MOV VAR_1,0
      MOV VAR_2,0
      MOV VAR_3,0
      MOV VAR_4,0  
      
       MOV AX,0 
      MOV BX,0 
                  
      
        
        mov cx,0
        mov bx,0
        mov si,0
        JMP impresionmul 
        ;imprime fila1 
        
        
        impresionmul:
        print " "
        mov al,RESULTADO[si] 
        call print_num
        inc si
        inc bx
        cmp bx,4 
        jne impresionmul
        printn " "
        jmp impresionmul1 
        ;imprime fila2 
        
        
        impresionmul1:
        print " "
        mov al,RESULTADO[si] 
        call print_num
        inc si
        inc bx
        cmp bx,8 
        jne impresionmul1
        printn " "
        jmp impresionmul2 
        ;imprime fila3 
        
        
        impresionmul2:
        print " "
        mov al,RESULTADO[si] 
        call print_num
        inc si
        inc bx
        cmp bx,12 
        jne impresionmul2
        printn " " 
        jmp impresionmul3 
        ;imprime fila4
        
        
        impresionmul3:
        print " "
        mov al,RESULTADO[si] 
        call print_num
        inc si
        inc bx
        cmp bx,16 
        jne impresionmul3
        printn " "
        mov cx,0
        mov bx,0
        mov si,0 
        
        
        
        
        ;*********-----------***********-----
        
      
     multiplicacion endp
        
        
        
        
        
        
      EXIT:     
            MOV AX, 4C00H
            INT 21H   
        
            

;---------------------------------
;---------------------------------       
       MENSAJE_M_1 PROC     NEAR        ;RUTINA PARA MOSTRAR MENSAJE 1 (MATRIZ 1)
            MOV DX,OFFSET MENSAJE_1     
            MOV AH,09H
            INT 21H
            CALL    ENTER_RET          
                      
            RET               
       MENSAJE_M_1  ENDP   
       
       MENSAJE_M_2  PROC    NEAR        ;RUTINA PARA MOSTRAR MENSAJE 2 (MATRIZ 2)
            MOV DX,OFFSET MENSAJE_2
            MOV AH,09H
            INT 21H
            CALL    ENTER_RET         
                      
            RET
       MENSAJE_M_2  ENDP
       
       MENSAJE_M_3  PROC    NEAR        ;RUTINA PARA MOSTRAR MENSAJE 3 (RESULTADO SUMA=)
            MOV DX,OFFSET MENSAJE_3
            MOV AH,09H
            INT 21H
            CALL    ENTER_RET
            
            RET
       MENSAJE_M_3  ENDP 
       
       MENSAJE_M_4  PROC    NEAR        ;RUTINA PARA MOSTRAR MENSAJE 4 (RESULTADO MULTIPLICACION=)
            MOV DX,OFFSET MENSAJE_4
            MOV AH,09H
            INT 21H
            CALL    ENTER_RET
            
            RET
       MENSAJE_M_4  ENDP
                         
       ENTER_RET    PROC    NEAR        ;RUTINA QUE GENERA ENTER Y RETORNO DE CARRO
            MOV AH,2
            MOV DL,10
            INT 21H
            MOV AH,2
            MOV DL,13
            INT 21H
            RET
       ENTER_RET    ENDP                     
           
            ; Retorno al Sistema Operativo
           
            
    END START 
     
.STACK
      

END  
