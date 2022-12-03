.MODEL SMALL
.STACK 100H
.DATA
        M1 DB 0DH, 0AH, "Enter a string : $"
        STR1 DB 80, 0 ,78 DUP('$')
        M2 DB 0DH, 0AH, "First 3 char : $"
.CODE
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

                LEA DX, M1
                MOV AH, 09H
                INT 21H

                LEA DX, STR1
                MOV AH, 0AH
                INT 21H

                LEA DX, M2
                MOV AH, 09H
                INT 21H

                LEA SI, STR1
                ADD SI, 02H
                MOV CL, 03H
          REP1: MOV DL, [SI]
                MOV AH, 02H
                INT 21H
                INC SI
                LOOP REP1

                MOV AH, 4CH
                INT 21H
        MAIN ENDP
END MAIN
