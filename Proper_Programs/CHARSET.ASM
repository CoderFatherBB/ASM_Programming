.MODEL SMALL
.STACK 100H
.DATA
.CODE
        MAIN PROC
                MOV CL, 00H

            L1: MOV DL, CL
                MOV AH, 02H
                INT 21H
                INC CL
                MOV DL, ' '
                MOV AH, 02H
                INT 21H

                MOV AH, 00H
                MOV AL, CL
                MOV BL, 16D
                DIV BL
                CMP AH, 00D
                JE L2
                        ;After FFH it will again increment and be back 00H
                CMP CL, 00H 
                JNZ L1

            L2: MOV DL, 0AH
                MOV AH, 02H
                INT 21H
                CMP CL, 00H
                JNZ L1

                MOV AH, 4CH
                INT 21H
        MAIN ENDP
END MAIN
