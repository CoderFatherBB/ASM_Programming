.MODEL SMALL
.STACK 100H
.DATA
	N1 DB 0FDH
	N2 DB 0DCH
	
	SUM_LSB DB 00H
	SUM_MSB DB 00H
.CODE
	MAIN PROC
		MOV AX, @DATA
		MOV DS, AX
		
                MOV AL, 00H             ; Initialize sum = 0
                MOV AH, 00H             ; Initialize carry = 0
		
		MOV AL, N1
		MOV BL, N2
                ADD AL, BL
		MOV SUM_LSB, AL 		; Move sum to memory
                ADC AH, 00H             ; Add if carry
                MOV SUM_MSB,AH          ; Move carry to memory
	
		MOV AH, 4CH
		INT 21H
	MAIN ENDP
END MAIN
