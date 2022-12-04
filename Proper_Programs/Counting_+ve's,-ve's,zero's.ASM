.MODEL SMALL
.STACK 100H
.DATA
        NUM DB 79H,85H,98H,00H,58H,00H,00H,46H,0B3H,00H,69H,88H,72H,0FFH,66H
        
        ZCNT DB 00H
        PCNT DB 00H
        NCNT DB 00H

        M1 DB 0AH,0DH,  "Number of zeros = $"
        M2 DB 0AH,0DH,  "Number of positives = $"
        M3 DB 0AH,0DH,  "Number of negative = $"

.CODE
        MAIN PROC
                MOV AX,@DATA
                MOV DS, AX


                LEA SI, NUM   

                MOV CX, 000FH 
         AGAIN: MOV AL,[SI]   

                
                CMP AL, 00H   
                JZ P1
                ROL AL, 01H   
                JC P2
                JMP P3        

                P1:  INC ZCNT 
                INC SI
                DEC CX
                JNZ AGAIN

                P2:  INC NCNT 
                INC SI
                DEC CX
                JNZ AGAIN

                P3:  INC PCNT 


                INC SI
                DEC CX
                JNZ AGAIN

                LEA DX, M2   
                MOV AH, 09H
                INT 21H

                MOV AX, 0000H

                MOV AL, PCNT 
                ADD AL, 30H
                MOV DL, AL
                MOV AH, 02H
                INT 21H

                LEA DX, M3
                MOV AH, 09H
                INT 21H

                MOV AL, NCNT 
                ADD AL, 30H
                MOV DL, AL
                MOV AH, 02H
                INT 21H

                LEA DX, M1
                MOV AH, 09H
                INT 21H

                MOV AL, ZCNT 
                ADD AL, 30H
                MOV DL, AL
                MOV AH, 02H
                INT 21H

                MOV AH, 4CH
                INT 21H

        MAIN ENDP
END MAIN
