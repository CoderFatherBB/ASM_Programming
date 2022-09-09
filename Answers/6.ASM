.MODEL SMALL
.STACK 100H
.DATA
        FNAME DB 0AH, 0DH, "FNAME : $"
        LNAME DB 0AH, 0DH, "LNAME : $"
        BDATE DB 0AH, 0DH, "BDATE : $"
        CITY DB 0AH, 0DH, "CITY : $"

        SFNAME DB 80, 0, 78 DUP('$')
        SLNAME DB 80, 0, 78 DUP('$')
        SBDATE DB 80, 0, 78 DUP('$')
        SCITY DB 80, 0, 78 DUP('$')
.CODE
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

                LEA DX, FNAME
                MOV AH, 09H
                INT 21H

                LEA DX, SFNAME
                MOV AH, 0AH
                INT 21H

                          
                LEA DX, LNAME
                MOV AH, 09H
                INT 21H

                LEA DX, SLNAME
                MOV AH, 0AH
                INT 21H


                LEA DX, BDATE
                MOV AH, 09H
                INT 21H

                LEA DX, SBDATE
                MOV AH, 0AH
                INT 21H


                LEA DX, CITY
                MOV AH, 09H
                INT 21H

                LEA DX, SCITY
                MOV AH, 0AH
                INT 21H


                MOV AH, 4CH
                INT 21H
        MAIN ENDP
END MAIN
