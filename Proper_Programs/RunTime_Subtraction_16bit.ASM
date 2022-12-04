.MODEL SMALL
.STACK 100H
.DATA
        M1 DB 0DH,0AH, "Enter a number: $"
        M2 DB 0DH,0AH, "DIFF is: $"
        N1 DW 000H
        N2 DW 000H
        DIFF_L DW 0000H
        DIFF_M DW 0000H
.code
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

             CALL INPUT
                MOV N1, BX
             CALL INPUT
                MOV N2, BX

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
            ;   MOV DX, AL
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
	INPUT ENDP

	SUBTRACTION PROC
               MOV AX, 0000H			; Initialize diff = 0 in AX
		MOV CX, 0000H			; Initialize borrow = 0 in CX

		MOV AX, N1	
		MOV BX, N2 	
                SUB AX, BX 
                MOV DIFF_L, AX                ; Move diff to memory
		ADC CX, 0000H 		; Generated borrow in AH if N1 < N2
                MOV DIFF_M, CX                ; Move borrow to memory
                   RET
	SUBTRACTION ENDP

	PRINT PROC

                MOV AH,09H
                LEA DX, M2
                INT 21H
		 ; To print tHe DIFF 

                MOV CL, 04H    ;Loop count
          REP2: MOV AX, DIFF_M
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV DIFF_M, AX
                AND AL, 0FH    ;Using logic AND to get tHe number on unit place only
                CMP AL, 09H
                JBE HI
                ADD AL, 07H
             HI:ADD AL, 30H    ;Generating tHe ASCII number of tHe number to display
                MOV DL, AL
                MOV AH, 02H
                INT 21H
                LOOP REP2

                MOV CL, 04H    ;Loop count
          REP3: MOV AX, DIFF_L
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV DIFF_L, AX
                AND AL, 0FH    ;Using logic AND to get tHe number on unit place only
                CMP AL, 09H
                JBE HI1
                ADD AL, 07H
            HI1:ADD AL, 30H    ;Generating tHe ASCII number of tHe number to display
                MOV DL, AL
                MOV AH, 02H
                INT 21H
                LOOP REP3
                   RET
	PRINT ENDP
END MAIN

