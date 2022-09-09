.MODEL SMALL
.STACK 100H
.DATA
.CODE
        MAIN PROC
                MOV DL, 'A'    ;ASCII char to display
                MOV AH, 02H    ;Service to display char
                INT 21H

                MOV DL, 'B'
                MOV AH, 02H
                INT 21H

                MOV DL, 0AH
                MOV AH, 02H
                INT 21H

                MOV DL, 0DH
                MOV AH, 02H
                INT 21H

                MOV DL, 'C'
                MOV AH, 02H
                INT 21H        ;Interpot DOS call

                MOV AH, 4CH    ;Return to OS
                INT 21H        ;Interpot DOS call
        MAIN ENDP
END MAIN

