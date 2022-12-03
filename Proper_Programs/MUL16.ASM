.MODEL SMALL
.STACK 100H
.DATA
        M1 DB 0DH,0AH, "Enter a number: $"
        M2 DB 0DH,0AH, "Sum is: $"
        N1 DW 000H
        N2 DW 000H
        PROD_LSB DW 0000H
        PROD_MSB DW 0000H
.code
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

             CALL INPUT
                MOV N1, BX
             CALL INPUT
                MOV N2, BX

             CALL MULTIPLICATION

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

	MULTIPLICATION PROC
                MOV AX, @DATA
		    MOV DS, AX

		    MOV AX, 0000H 		; Initialize sum = 0 in AX
		    MOV DX, 0000H 		; Initialize carry = 0 in CX

		    MOV AX, N1 
		    MOV BX, N2 
		    MUL BX 
		    MOV PROD_LSB, AX    	; Move product LSB to memory
		    MOV PROD_MSB, DX    	; Move product MSB to memory

                   RET
	MULTIPLICATION ENDP

	PRINT PROC

                MOV AH,09H
                LEA DX, M2
                INT 21H
		 ; To print tHe sum 

                MOV CL, 04H    ;Loop count
          REP2: MOV AX, PROD_MSB
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV PROD_MSB, AX
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
          REP3: MOV AX, PROD_LSB
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV PROD_LSB, AX
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

