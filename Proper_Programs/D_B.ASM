.MODEL SMALL
.STACK 100H
.DATA

	  M2 DB 0DH, 0AH, "Enter a number 8 bit: $"
        M3 DB 0DH,0AH, "Binary is: $"
        N2 DB 00H
	  N4 DB 00H
	  N3 DB 8 DUP(0)
        MULTI DB 01H

.code
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

             CALL INPUT
                MOV N2, BL
		 CALL CONVERT
             CALL DIVISION

             CALL PRINT

                MOV AH, 4CH
                INT 21H
	MAIN ENDP

	INPUT PROC
               MOV CH, 02H

               MOV AH, 09H
               LEA DX, M2
               INT 21H

           i1: MOV AH, 01H
               INT 21H
               SUB AL, 30H
               CMP AL, 09H
               JBE i2
               SUB AL, 07H
			
			
           i2: CMP CH, 01H
               JZ i3
               ROL AL, 04H
               MOV BL, AL

           i3: DEC CH
               JNZ i1
               ADD BL, AL
                   RET
	INPUT ENDP
      
      CONVERT PROC
		    MOV CL, 02H
          REP3: MOV AL, N2
                AND AL, 0FH
                MUL MULTI
                ADD N4, AL
                MOV AL, N2
                ROR AL, 04H    ;Rotate the number (right rotate)
                MOV N2, AL
                MOV AL, MULTI
                MOV BL, 0AH
                MUL BL
                MOV MULTI, AL
                LOOP REP3
	         RET
	CONVERT ENDP

	DIVISION PROC
		LEA SI, N3
		ADD SI, 07H
    AGAIN1: MOV AH, 00H
		MOV AL, N4 		; Move N1 to AX - Dividend
		MOV BL, 02H 		; Move N2 to BL - Divisior
		DIV BL 		; AL = AX / BL     AH = Remainder
		MOV N4, AL    	; Move quotient to memory
            MOV [SI], AH
		DEC SI
		CMP N2, 00H
		JNZ AGAIN1        
			RET
	DIVISION ENDP

	PRINT PROC

            LEA DX, M3
            MOV AH, 09H
            INT 21H

            MOV CL, 8D
            LEA SI, N3
     again: MOV DL, [SI]
		ADD DL, 30H
            MOV AH, 02H
            INT 21H
            INC SI
            LOOP again 

                   RET
	PRINT ENDP
END MAIN
