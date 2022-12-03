.MODEL SMALL
.STACK 100H
.DATA
        M1 DB 0DH, 0AH, "Enter a number 16 bit: $"
	  M2 DB 0DH, 0AH, "Enter a number 8 bit: $"
        M3 DB 0DH,0AH, "Division is: $"
        N1 DW 0000H
        N2 DB 00H
        QUOT DB 00H

.code
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

             CALL INPUT16
                MOV N1, BX
             CALL INPUT8
                MOV N2, BL

             CALL DIVISION

             CALL PRINT

                MOV AH, 4CH
                INT 21H
	MAIN ENDP

      INPUT16 PROC
               MOV CH, 02H

               MOV AH, 09H
               LEA DX, M1
               INT 21H

           i10: MOV AH, 01H
               INT 21H
            ;   MOV DX, AL
               SUB AL, 30H
               CMP AL, 09H
               JBE i20
               SUB AL, 07H
			
			
           i20: CMP CH, 01H
               JZ i30
               ROL AL, 04H
               MOV BL, AL

           i30: DEC CH
               JNZ i10
               ADD BL, AL

               MOV BH, BL

               MOV CH, 02H

           i11: MOV AH, 01H
               INT 21H
            ;   MOV DX, AL
               SUB AL, 30H
               CMP AL, 09H
               JBE i12
               SUB AL, 07H
			
			
           i12: CMP CH, 01H
               JZ i13
               ROL AL, 04H
               MOV BL, AL

           i13: DEC CH
               JNZ i11
               ADD BL, AL
               
                 RET
	INPUT16 ENDP

	INPUT8 PROC
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
	INPUT8 ENDP

	DIVISION PROC
		MOV AX, N1 		; Move N1 to AX - Dividend
		MOV BL, N2 		; Move N2 to BL - Divisior
		DIV BL 		; AL = AX / BL     AH = Remainder
		ADD QUOT, AL    	; Move quotient to memory
                    RET
	DIVISION ENDP

	PRINT PROC

                MOV AH,09H
                LEA DX, M3
                INT 21H
		 ; To print tHe QUOT 

                MOV CL, 02H    ;Loop count
          REP2: MOV AL, QUOT
                ROL AL, 04H    ;Rotate tHe number (left rotate)
                MOV QUOT, AL
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
