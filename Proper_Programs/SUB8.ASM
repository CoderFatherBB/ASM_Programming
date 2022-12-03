.MODEL SMALL
.STACK 100H
.DATA
        M1 DB 0DH, 0AH, "Enter a number: $"
        M2 DB 0DH,0AH, "DIFF is: $"
        N1 DB 00H
        N2 DB 00H
        DIFF DW 0000H

.code
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

             CALL INPUT
                MOV N1, BL
             CALL INPUT
                MOV N2, BL

             CALL SUBTRACTION

             CALL PRINT

                MOV AH, 4CH
                INT 21H
	MAIN ENDP

	INPUT PROC
               MOV CH, 02H

               MOV AH, 09H
               LEA DX, M1
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

	SUBTRACTION PROC
		MOV AL, 00H			; Initialize diff = 0
		MOV AH, 00H			; Initialize borrow = 0

		MOV AL, N1	
		MOV BL, N2 	
		SUB AL, BL	
		ADC AH, 00H 		; Generated borrow in AH if N1 < N2
		MOV DIFF, AX 		; Move borrow to memory
                    RET
	SUBTRACTION ENDP

	PRINT PROC

                MOV AH,09H
                LEA DX, M2
                INT 21H
		 ; To print tHe DIFF 

                MOV CL, 04H    ;Loop count
          REP2: MOV AX, DIFF
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV DIFF, AX
                AND AL, 0FH    ;Using logic AND to get tHe number on unit place only
                CMP AL, 09H
                JBE HI
                ADD AL, 07H
             HI:ADD AL, 30H    ;Generating tHe ASCII number of tHe number to display
                MOV DL, AL
                MOV AH, 02H
                INT 21H
                LOOP REP2
                   RET
	PRINT ENDP
END MAIN
