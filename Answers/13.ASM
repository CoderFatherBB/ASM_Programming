.MODEL SMALL
.STACK 100H
.DATA
	N1 DW 0ABCDH
	N2 DB 0BDH

	QUOT DB 00H
	REM DB 00H 
.CODE
	MAIN PROC
		MOV AX, @DATA
		MOV DS, AX 	
		
		MOV AX, N1 		; Move N1 to AX - Dividend
		MOV BL, N2 		; Move N2 to BL - Divisior
		DIV BL 		; AL = AX / BL     AH = Remainder
		MOV QUOT, AL    	; Move quotient to memory
		MOV REM, AH 	; Move remainder to memory
		
		MOV AH, 4CH
		INT 21H
	MAIN ENDP
END MAIN