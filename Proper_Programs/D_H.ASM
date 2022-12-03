.MODEL SMALL
.STACK 100H
.DATA
            M1 DB 0DH,0AH, "Enter a number: $"
            M2 DB 0DH, 0AH, "Hexadecimal number: $"
           
            NUMH_M DW 0000H
            NUMH_L DW 0000H
            NUMD DB 5 DUP(0)
           
            MULTI DW 10000D
            DIVI DW 0010D
.CODE
    MAIN PROC
               MOV AX, @DATA
               MOV DS, AX

             CALL INPUT

             CALL CONVERT 

             CALL PRINT

                MOV AH, 4CH
                INT 21H
	MAIN ENDP

      INPUT PROC
               MOV CH, 02H

               MOV AH, 09H
               LEA DX, M1
               INT 21H
		   
                   MOV CX, 0005H
		   LEA SI, NUMD
         REP1: MOV AH, 01H
		   INT 21H
		   SUB AL, 30H
		   MOV [SI], AL
		   INC SI
                   LOOP REP1

                 RET
	INPUT ENDP

	CONVERT PROC
			
		    MOV DX, 0000H
                    MOV CL, 05H
                    LEA SI, NUMD

            REP2:   MOV DX, 0000H
                    MOV BH, 00H
                    MOV BL, [SI]
		    MOV AX, MULTI
                    MUL BX
		    ADD NUMH_L, AX
		    ADC NUMH_M, DX

                    MOV DX, 0000H
		    INC SI
                    MOV BX, DIVI
		    MOV AX, MULTI
                    DIV BX
		    MOV MULTI, AX
                
                LOOP REP2
			
	         RET
	CONVERT ENDP

      PRINT PROC
              
              LEA DX, M2
              MOV AH, 09H
              INT 21H

                MOV CL, 04H    ;Loop count
          REP3: MOV AX, NUMH_M
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV NUMH_M, AX
                AND AL, 0FH    ;Using logic AND to get tHe number on unit place only
                CMP AL, 09H
                JBE HI
                ADD AL, 07H
             HI:ADD AL, 30H    ;Generating tHe ASCII number of tHe number to display
                MOV DL, AL
                MOV AH, 02H
                INT 21H
                LOOP REP3

                MOV CL, 04H    ;Loop count
          REP4: MOV AX, NUMH_L
                ROL AX, 04H    ;Rotate tHe number (left rotate)
                MOV NUMH_L, AX
                AND AL, 0FH    ;Using logic AND to get tHe number on unit place only
                CMP AL, 09H
                JBE HI1
                ADD AL, 07H
            HI1:ADD AL, 30H    ;Generating tHe ASCII number of tHe number to display
                MOV DL, AL
                MOV AH, 02H
                INT 21H
                LOOP REP4

                RET
	PRINT ENDP

END MAIN 
