.MODEL SMALL
.STACK 100H
.DATA
        MEASSAGE DB 80, 0, 78 DUP('$')
.CODE
        MAIN PROC
              MOV AX, @DATA
              MOV DS, AX
              
              LEA DX, MESSAGE
              MOV AH, 0AH
              INT 21H
              
              MOV AH, 4CH
              INT 21H
        MAIN ENDP
END MAIN
