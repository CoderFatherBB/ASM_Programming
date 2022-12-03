.MODEL SMALL
.STACK 100H
.DATA
	  M DB 0AH, 0DH, "Enter a number : $"
        NUM DB 5 DUP(0)

        SUM DW 0000H
        SUMH DW 0000H
        MULTI DB 01H
        M1 DB 0AH, 0DH, "The total marks : $"

        PERH DB 00H   ; Percentage in Hexadecimal
        PERD DB 00H   ; Percentage in Decimal
        M2 DB 0AH, 0DH, "The percntage is : $"

        M3 DB 0AH, 0DH, "The grade is : $"
        GRADE DB 00H

.CODE
        MAIN PROC
                MOV AX, @DATA
                MOV DS, AX

		    LEA SI, NUM     
		CALL INPUT
		    MOV [SI], BL
		    INC SI  
		CALL INPUT
		    MOV [SI], BL
		    INC SI  
		CALL INPUT
		    MOV [SI], BL
		    INC SI  
		CALL INPUT
		    MOV [SI], BL
		    INC SI  
		CALL INPUT
		    MOV [SI], BL  
		
                MOV BX, 0000H
                MOV AX, 0000H


            ; Addition loop

                MOV CL, 05H       ;Loop count
          REP1: ADD AL, NUM[BX]
                DAA               ;Converting Hexadecimal to Decimal
                ADC AH, 00H
                INC BX
                LOOP REP1
                MOV SUM, AX

                LEA DX, M1
                MOV AH, 09H    ;Display the message
                INT 21H


            ; To print the sum 

                MOV CL, 04H    ;Loop count
          REP2: MOV AX, SUM
                ROL AX, 04H    ;Rotate the number (left rotate)
                MOV SUM, AX
                AND AL, 0FH    ;Using logic AND to get the number on unit place only
                ADD AL, 30H    ;Generating the ASCII number of the number to display
                MOV DL, AL
                MOV AH, 02H
                INT 21H
                DEC CL
                JNZ REP2
               ; LOOP REP2


           ; To convert sum to hexadecimal to find avgrage

                MOV CL, 03H
          REP3: MOV AX, SUM
                AND AL, 0FH
                MUL MULTI
                ADD SUMH, AX
                MOV AX, SUM
                ROR AX, 04H    ;Rotate the number (right rotate)
                MOV SUM, AX
                MOV AL, MULTI
                MOV BL, 0AH
                MUL BL
                MOV MULTI, AL
                LOOP REP3


           ; To find avg

                MOV AX, SUMH
                MOV BL, 05H
                DIV BL
                MOV PERH, AL


           ; To convert avg in decimal

                MOV CL, PERH
                MOV AL, 00H
          REP4: ADD AL, 01H
                DAA
                DEC CL
                JNZ REP4
               ; LOOP REP4
                MOV PERD, AL

                LEA DX, M2
                MOV AH, 09H    ;Display the message
                INT 21H


           ; To print the avg 

                MOV CL, 02H    ;Loop count
          REP5: MOV AL, PERD
                ROL AL, 04H    ;Rotate the number (left rotate)
                MOV PERD, AL
                AND AL, 0FH    ;Using logic AND to get the number on unit place only
                ADD AL, 30H    ;Generating the ASCII number of the number to display
                MOV DL, AL
                MOV AH, 02H
                INT 21H
                LOOP REP5

           ; To print the Grade on the screen

                LEA DX, M3
                MOV AH, 09H
                INT 21H

                MOV AL, PERD
                CMP AL, 40H
                JB GRADEF
                CMP AL, 50H
                JB GRADEP
                CMP AL, 60H
                JB GRADEC
                CMP AL, 70H
                JB GRADEB
                CMP AL, 80H
                JB GRADEA

                MOV GRADE,'O'
                JMP DG
        GRADEF: MOV GRADE,'F'
                JMP DG
        GRADEP: MOV GRADE,'P'
                JMP DG
        GRADEC: MOV GRADE,'C'
                JMP DG
        GRADEB: MOV GRADE,'B'
                JMP DG
        GRADEA: MOV GRADE,'A'
                JMP DG

            DG: MOV DL,GRADE
                MOV AH,02H
                INT 21H

                MOV AH, 4CH
                INT 21H
        MAIN ENDP

	INPUT PROC
               MOV CH, 02H

               MOV AH, 09H
               LEA DX, M
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

END MAIN

