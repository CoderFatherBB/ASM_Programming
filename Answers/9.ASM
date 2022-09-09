.MODEL SMALL
.STACK 100H
.DATA
	N1 DB 0DCH
	N2 DB 0FDH

	DIFF_LSB DB 00H
	DIFF_MSB DB 00H
.CODE
	MAIN PROC
		MOV AX, @DATA
		MOV DS, AX 

		MOV AL, 00H			; Initialize diff = 0
		MOV AH, 00H			; Initialize borrow = 0

		MOV AL, N1	
		MOV BL, N2 	
		SUB AL, BL	
		MOV DIFF_LSB, AL 		; Move diff to memory
		ADC AH, 00H 		; Generated borrow in AH if N1 < N2
		MOV DIFF_MSB, AH 		; Move borrow to memory

		MOV AH, 4CH
		INT 21H
	MAIN ENDP
END MAIN