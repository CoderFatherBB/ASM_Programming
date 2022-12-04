.MODEL SMALL
.STACK 100H
.DATA
            M1 DB 0DH,0AH, "Enter a number: $"
            M2 DB 0DH, 0AH, "Decimal number: $"
            NUMH DW 0000H
            NUMD DB 5 DUP(0)
.CODE
    MAIN PROC
               MOV AX, @DATA
               MOV DS, AX

             CALL INPUT
                MOV NUMH, BX
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
            ;  MOV DX, AL
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

	CONVERT PROC

               MOV DX, 0000H
               MOV AX, NUMH
               MOV BX, 000AH
               LEA SI, NUMD
         REP1: DIV BX
               MOV [SI], DL
               MOV DX, 0000H
               INC SI
               CMP AX, 0000H
               JNZ REP1     
			
	         RET
	CONVERT ENDP

      PRINT PROC
              
              LEA DX, M2
              MOV AH, 09H
              INT 21H

             ; MOV CX, 0005H
              DEC SI
         REP8:MOV DL,[SI]
              ADD DL ,30H
              MOV AH, 02H
              INT 21H
              DEC SI
              CMP SI, DI
              JNB REP8
                RET
	PRINT ENDP

END MAIN 
