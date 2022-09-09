.MODEL SMALL
.STACK 100H
.DATA
	N1 DW 7354H
	N2 DW 8A89H

	DIFF_LSB DW 0000H
	DIFF_MSB DW 0000H
.CODE
	MAIN PROC
		MOV AX, @DATA
		MOV DS, AX 

		MOV AX, 0000H			; Initialize diff = 0 in AX
		MOV CX, 0000H			; Initialize borrow = 0 in CX

		MOV AX, N1	
		MOV BX, N2 	
                SUB AX, BX 
		MOV DIFF_LSB, AX 		; Move diff to memory
		ADC CX, 0000H 		; Generated borrow in AH if N1 < N2
		MOV DIFF_MSB, CX 		; Move borrow to memory

		MOV AH, 4CH
		INT 21H
	MAIN ENDP
END MAIN
