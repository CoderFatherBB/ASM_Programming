.MODEL SMALL
.STACK 100H
.DATA
        MESSAGE DB "MY NAME IS BHAVIN$"
.CODE
        MAIN PROC
                MOV AX, @DATA     ;Base Address stored in AX of DATA
                MOV DS, AX        
                LEA DX, MESSAGE   ;Load Effective Address

                MOV AH, 09H       ;09 for sidplay to string
                INT 21H

                MOV AH, 4CH       ;Return to OS
                INT 21H
        MAIN ENDP
END MAIN
