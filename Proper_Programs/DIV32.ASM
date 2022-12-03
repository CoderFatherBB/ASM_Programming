.MODEL SMALL
.STACK 100H
.DATA
        M1 DB 0DH, 0AH, "Enter a number 32 bit : $"
        M2 DB 0DH, 0AH, "Enter a number 16 bit : $"
        M3 DB 0DH,0AH, "Division is : $"
        M4 DB 0DH,0AH, "Remainder is : $"
        N1_LSB DW 0000H
        N1_MSB DW 0000H
        N2 DW 0000H
        QUOT DW 0000H
        REMA DW 0000H

.code
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

             CALL INPUT32
                MOV N1_MSB, BX
                MOV N1_LSB, DX
		 
             CALL INPUT16
                MOV N2, BX

             CALL DIVISION

             CALL PRINT

                MOV AH, 4CH
                INT 21H
	MAIN ENDP

	INPUT32 PROC
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

		   
               MOV CH, 02H

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
               MOV DL, AL

           i30: DEC CH
               JNZ i10
               ADD DL, AL

               MOV DH, DL

               MOV CH, 02H

           i111: MOV AH, 01H
               INT 21H
            ;   MOV DX, AL
               SUB AL, 30H
               CMP AL, 09H
               JBE i122
               SUB AL, 07H
			
			
           i122: CMP CH, 01H
               JZ i133
               ROL AL, 04H
               MOV DL, AL

           i133: DEC CH
               JNZ i111
               ADD DL, AL 

                   RET

		   
	INPUT32 ENDP

      INPUT16 PROC
               MOV CH, 02H

               MOV AH, 09H
               LEA DX, M2
               INT 21H

           i100: MOV AH, 01H
               INT 21H
            ;   MOV DX, AL
               SUB AL, 30H
               CMP AL, 09H
               JBE i200
               SUB AL, 07H
			
			
           i200: CMP CH, 01H
               JZ i300
               ROL AL, 04H
               MOV BL, AL

           i300: DEC CH
               JNZ i100
               ADD BL, AL

               MOV BH, BL

               MOV CH, 02H

           i112: MOV AH, 01H
               INT 21H
            ;   MOV DX, AL
               SUB AL, 30H
               CMP AL, 09H
               JBE i123
               SUB AL, 07H
			
			
           i123: CMP CH, 01H
               JZ i134
               ROL AL, 04H
               MOV BL, AL

           i134: DEC CH
               JNZ i112
               ADD BL, AL
               
                 RET
	INPUT16 ENDP

	DIVISION PROC
		MOV DX, N1_MSB
		MOV AX, N1_LSB 		; Move N1 to AX - Dividend
		MOV BX, N2 		; Move N2 to BL - Divisior
		DIV BX 		; AX = DX:AX / BX     DX = Remainder
		ADD QUOT, AX    	; Move quotient to memory
                ADD REMA, DX
                    RET
	DIVISION ENDP

	PRINT PROC

                MOV AH,09H
                LEA DX, M3
                INT 21H
		 ; To print tHe QUOT 

                MOV CL, 04H    ;Loop count
          REP2: MOV AX, QUOT
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV QUOT, AX
                AND AL, 0FH    ;Using logic AND to get tHe number on unit place only
                CMP AL, 09H
                JBE HI
                ADD AL, 07H
             HI:ADD AL, 30H    ;Generating tHe ASCII number of tHe number to display
                MOV DL, AL
                MOV AH, 02H
                INT 21H
                LOOP REP2

                MOV AH,09H
                LEA DX, M4
                INT 21H
                 ; To print tHe REMA 

                MOV CL, 04H    ;Loop count
          REP4: MOV AX, REMA
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV REMA, AX
                AND AL, 0FH    ;Using logic AND to get tHe number on unit place only
                CMP AL, 09H
                JBE HII
                ADD AL, 07H
             HII:ADD AL, 30H    ;Generating tHe ASCII number of tHe number to display
                MOV DL, AL
                MOV AH, 02H
                INT 21H
                LOOP REP4

                   RET
	PRINT ENDP
END MAIN
