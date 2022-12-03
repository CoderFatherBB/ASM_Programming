.MODEL SMALL
.STACK 100H
.DATA
        MSG1 DB 0DH, 0AH, 'Enter a string in upper case: $'
        MSG2 DB 0DH, 0AH, 'In lower case it is: $'
        STR1 DB 80, 0, 78 DUP('$')

.CODE

        MAIN PROC
        
            MOV AX, @DATA       
            MOV DS,AX           
            
            
            LEA DX,MSG1         
            MOV AH,09H            
            INT 21H            
           
            LEA DX, STR1
            MOV AH, 0AH           
            INT 21H 
        
            LEA DX,MSG2         
            MOV AH,09H            
            INT 21H 
        
            LEA SI, STR1
            ADD SI, 02H
      REP1: MOV AL, [SI] 
            CMP AL, '$'
            JE EX       
            ADD AL, 20H 
            MOV DL, AL
            MOV AH, 02H
            INT 21H
            INC SI
            LOOP REP1                
            
            
        EX: MOV AH,4CH
            INT 21H           
    
MAIN ENDP
END MAIN
