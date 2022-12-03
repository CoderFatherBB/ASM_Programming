.MODEL SMALL 
.STACK 100H 
.DATA
	N1 DW 7354H 
	N2 DW 8A89H 

	SUM_LSB DW 0000H
	SUM_MSB DW 0000H
.CODE
	MAIN PROC
		MOV AX, @DATA
		MOV DS, AX

		MOV AX, 0000H 		; Initialize sum = 0 in AX
		MOV CX, 0000H 		; Initialize carry = 0 in CX

		MOV AX, N1 
		MOV BX, N2 
		ADD AX, BX 
		MOV SUM_LSB, AX 		; Move sum to memory
		ADC CX, 0000H 		; Add if carry
		MOV SUM_MSB, CX 		; Move carry to memory

		MOV AH,4CH
		INT 21H
	MAIN ENDP
END MAIN
