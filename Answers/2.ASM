.MODEL SMALL
.STACK 100H
.DATA
.CODE
        MAIN PROC
                MOV AH, 01H    ;Read char and stored in AL
                INT 21H        ;Call Function

                MOV DL, AL     ;Display 
                MOV AH, 02H
                INT 21H

                MOV AH, 4CH    ;Return to OS
                INT 21H
        MAIN ENDP
END MAIN
