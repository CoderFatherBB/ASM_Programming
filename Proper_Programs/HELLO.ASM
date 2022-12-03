.MODEL SMALL
.STACK 100H
.DATA
        STR1 DB "HELLO$"
.CODE
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

                LEA SI, STR1
          REP1: MOV DL, [SI]
                MOV AH, 02H
                INT 21H

                MOV DL, 0DH
                MOV AH, 02H
                INT 21H
                MOV DL, 0AH
                MOV AH, 02H
                INT 21H
                
                INC SI
                MOV AL, [SI]
                CMP AL, '$'
                JE EX
                LOOP REP1

            EX: MOV AH, 4CH
                INT 21H
        MAIN ENDP
END MAIN
