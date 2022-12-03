.MODEL SMALL
.STACK 100H
.DATA
        M1 DB 0DH, 0AH, "Enter a number: $"
        M2 DB 0DH,0AH, "Sum is: $"
        N1 DB 00H
        N2 DB 00H
        SUM DW 0000H

.code
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

             CALL INPUT
                MOV N1, BL
             CALL INPUT
                MOV N2, BL

             CALL ADDITION

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

	ADDITION PROC
		MOV AL, 00H             ; InitiALize sum = 0
                MOV AH, 00H             ; InitiALize carry = 0
		
                MOV AL, N1
                MOV BL, N2
                ADD AL, BL
                ADC AH, 00H             ; Add if carry
                MOV SUM, AX
                    RET
	ADDITION ENDP

	PRINT PROC

                MOV AH,09H
                LEA DX, M2
                INT 21H
		 ; To print tHe sum 

                MOV CL, 04H    ;Loop count
          REP2: MOV AX, SUM
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV SUM, AX
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
