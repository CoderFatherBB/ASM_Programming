.MODEL SMALL
.STACK 100H
.DATA
	N1 DB 0FFH
	N2 DB 0FFH

	PROD_LSB DB 00H
	PROD_MSB DB 00H
.CODE
	MAIN PROC
		MOV AX, @DATA

		MOV DS, AX 			; Initialise the segment

		MOV AL, N1 
		MOV BL, N2 
		MUL BL 
		MOV PROD_LSB, AL    	; Move product LSB to memory
		MOV PROD_MSB, AH    	; Move product MSB to memory

		MOV AH, 4CH
		INT 21H
	MAIN ENDP
END MAIN