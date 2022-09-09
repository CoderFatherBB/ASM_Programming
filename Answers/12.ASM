.MODEL SMALL
.STACK 100H
.DATA
	N1 DW 1234H
	N2 DW 0ABCDH

	PROD_LSB DW 0000H
	PROD_MSB DW 0000H
.CODE
	MAIN PROC
		MOV AX, @DATA

		MOV DS, AX 			; Initialise the segment

		MOV AX, N1 
		MOV BX, N2 
		MUL BX 
		MOV PROD_LSB, AX    	; Move product LSB to memory
		MOV PROD_MSB, DX    	; Move product MSB to memory

		MOV AH, 4CH
		INT 21H
	MAIN ENDP
END MAIN