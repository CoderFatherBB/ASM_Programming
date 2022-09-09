.MODEL SMALL
.STACK 100H
.DATA
        FNAME DB 0AH, 0DH, "FNAME : BHAVIN $"
        LNAME DB 0AH, 0DH, "LNAME : BALDOTA $"
        BDATE DB 0AH, 0DH, "BDATE : 15/06/2003 $"
        CITY DB 0AH, 0DH, "CITY : PUNE$"
.CODE
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

                LEA DX, FNAME
                MOV AH, 09H
                INT 21H

                LEA DX, LNAME
                MOV AH, 09H
                INT 21H

                LEA DX, BDATE
                MOV AH, 09H
                INT 21H

                LEA DX, CITY
                MOV AH, 09H
                INT 21H

                MOV AH, 4CH
                INT 21H
        MAIN ENDP
END MAIN
