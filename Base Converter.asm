
                    
					;PROJECT: BASE CONVERTER
                                
;***********************************************************************************************

                               
.MODEL MEDIUM

.STACK 100H

.DATA
    
    FLAG DW ?
    COUNT DB ?
    REM DW ?
    COUNT_HEX DW 0
    OUTD DW ?
    IND DB ? 
    SELECT DB ?    
    INP1 DW ?   ; save Decimal_d input
    count_x DB ?
    D1 DB ?     ; save 1st Decimal_d digit
    D2 DB ?     ; save 2nd Decimal_d digit
    D3 DB ?     ; save 3rd Decimal_d digit
    D4 DB ?     ; save 4th Decimal_d digit
    D5 DB ?     ; save 5th Decimal_d digit
	
    
    OP_MESSAGE DB 0DH , 0AH , 0DH , 0AH , 'ALL OPERATIONS : $'
    MESSAGE_1 DB 0DH , 0AH , '1. BINARY TO HEXA-DECIMAL CONVERSION $'
    MESSAGE_2 DB 0DH , 0AH , '2. HEXA-DECIMAL TO BINARY CONVERSION $'
    MESSAGE_3 DB 0DH , 0AH , '3. BINARY TO DECIMAL CONVERSION $'
    MESSAGE_4 DB 0DH , 0AH , '4. HEXA-DECIMAL TO DECIMAL CONVERSION $'
    MESSAGE_5 DB 0DH , 0AH , '5. DECIMAL TO BINARY CONVERSION $'
    MESSAGE_6 DB 0DH , 0AH , '6. DECIMAL TO HEXA-DECIMAL CONVERSION $'
    MESSAGE_7 DB 0DH , 0AH , '7. EXIT PROGRAM $'

    PRESS_CHOICE DB 0DH , 0AH , 'PRESS A NUMBER (1-6) TO DO THAT OPERATION : $'
    ERROR_MESSAGE DB 0DH , 0AH , 'PLEASE , ENTER THE NUMER AGAIN APPROPROAITELY... !!! $'
    INVALID DB 0DH , 0AH , 'INVALID NUMBER. TRY AGAIN... $'
    TRY_AGAIN DB 0DH , 0AH , 'DO YOU WANT TRY AGAIN? PRESS Y OR N: $'
    
    BINARY_NUMBER DB 0DH , 0AH , 'INPUT A BINARY NUMBER : $'
    HEXA_NUMBER DB 0DH , 0AH , 'INPUT THE HEXADECIMAL NUMBER ( MAXIMUM OF 4 DIGIT ) : $'
    
    SHOW_HEX DB 0DH , 0AH , 'IN HEXA-DECIMAL : $'
    SHOW_DEC DB 0DH , 0AH , 'IN DECIMAL : $'
    SHOW_BIN DB 0DH , 0AH , 'IN BINARY : $'
    
    NEW_LINE DB 0DH , 0AH , '$'    
    
    OP1 db '1. Decimal_d TO BINARY $' 
    OP2 db '2. Decimal_d TO HEXADecimal_d $'
    
    NEWL DB 10,13,'$'   ;newline    
    
    Decimal_dINP DB 'FIRST INSERT + OR - THEN INSERT A VALUE BETWEEN 0-65535 : $'                          
    INDecimal_d DB 'DECIMAL VALUE: $'
    INBINARY DB 'BINARY VALUE: $'
    INHEXADecimal_d DB 'HEXA-DECIMAL VALUE: $'    
    error_rrMSG DB 'INPUT ERROR...!!! WRONG KEY INSERTED $'
    
    inp dw ?   
	

.CODE
    
    MAIN PROC
        
        MOV AX , @DATA
        MOV DS , AX
		

        MENU_BAR:                   ;MENU BAR LABEL 
            
            LEA DX , OP_MESSAGE          
            MOV AH , 9
            INT 21H
            
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
            
            LEA DX , MESSAGE_1      ;PRINT ALL OPERATIONS MESSAGES
            MOV AH , 9
            INT 21H
            
            LEA DX , MESSAGE_2
            MOV AH , 9
            INT 21H
            
            LEA DX , MESSAGE_3
            MOV AH , 9
            INT 21H
            
            LEA DX , MESSAGE_4
            MOV AH , 9
            INT 21H
            
            LEA DX , MESSAGE_5
            MOV AH , 9
            INT 21H
            
            LEA DX , MESSAGE_6
            MOV AH , 9
            INT 21H
            
            LEA DX , MESSAGE_7
            MOV AH , 9
            INT 21H
            
            LEA DX , NEW_LINE       
            MOV AH , 9
            INT 21H
            
            LEA DX , PRESS_CHOICE   ;PRINT CHOICE INPUT MESSAGE
            MOV AH , 9
            INT 21H            
			
                
        INPUT_CHOICE:           ;INPUT_CHOICE LABEL 
        
            MOV AH , 1          ;TAKE INPUT
            INT 21H
            MOV SELECT,AL        
            
            CMP AL , 49         ;COMPARE WITH INPUTED VALUE 
            JE BIN_TO_HEX
            
            CMP AL , 50
            JE HEX_TO_BIN
            
            CMP AL , 51
            JE BIN_TO_DEC
            
            CMP AL , 52
            JE HEX_TO_DEC
            
            CMP AL , 53
            JE Decimal_d
            
            CMP AL , 54
            JE Decimal_d
            
            CMP AL , 55
            JE EXIT
            
            CMP AL , 49         ;FOR WRONG INPUT
            JL ERROR
            
            CMP AL , 55                                            
            JG ERROR
        
        
        ERROR:                          ;ERROR LABEL
            
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
            
            LEA DX , ERROR_MESSAGE      ;ERROR MESSAGE SHOW
            MOV AH , 9
            INT 21H
            
            JMP MENU_BAR                ;JUMP TO THE MENU BAR TO GET THE INPUT AGAIN
        
               
        AGAIN:                  ;AGAIN LABEL 
        
            LEA DX,NEW_LINE     
            MOV AH,9     
            INT 21H 
             
            LEA DX,TRY_AGAIN       ;SHOW TRY AGAIN MESSAGE
            MOV AH,9     
            INT 21H
             
            MOV AH,1       
            INT 21H         
                     
            CMP AL,89
            JE  MENU_BAR        ;COMPARING WITH ASCII CHARS
    
            CMP AL,121
            JE  MENU_BAR  
    
            CMP AL,89       
            JNE  EXIT  
    
            CMP AL,121
            JNE  EXIT
                
        
        ERROR_BIN:                ;ERROR_BIN_1 LABEL
        
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
            
            LEA DX , INVALID    ;SHOW INVALID NUMBER
            MOV AH , 9
            INT 21H
                    
        
        BIN_TO_HEX:                     ;BINARY TO HEXA-DECIMAL LABEL 
            
            LEA DX , NEW_LINE       
            MOV AH , 9
            INT 21H
            
            LEA DX , BINARY_NUMBER      ;BINARY NUMBER INPUT MESSAGE SHOW
            MOV AH , 9
            INT 21H
            
            MOV FLAG , 49
            JMP INPUT_BINARY    
        
        
        INPUT_BINARY:       ;INPUT_BINARY LABEL
         
            XOR AX , AX     ;CLEARING ALL REGISTERS
            XOR BX , BX
            XOR CX , CX
            XOR DX , DX
            MOV CL , 1      ;SETTING 1 TO CL
			MOV INP , 0
            
               
        INPUT_BINARY2:          ;INPUT_BINARY2 LABEL
         
            MOV AH , 1          ;INPUT BINARY NUMBER
            INT 21H
            
            CMP AL , 0DH        ;CHECK IF ENTER IS PRESSED OR NOT
            JE ENTER                       
            
            CMP AL , 48
            JNE BINARY_CHECK
            
             
        BINARY_CONTINUE:            ;BINARY_CONTINUE LABEL 
        
            SUB AL , 48
            SHL BX , CL
            OR BL , AL
            
            INC INP
            CMP INP , 16
            JE ENTER
            JMP INPUT_BINARY2       ;JUMP FOR INPUT ANOTHER DIGIT AGAIN    
                
        
        BINARY_CHECK:               ;BINARY_CHECK LABEL
        
            CMP AL , 49             ;TO CHECK IF THERE OTHER VALUE INPUTED RATHER THAN 1 AND 0
            JNE ERROR_BIN           ;IF OTHER VALUE INPUTED ERROR MESSAGE WILL DISPLAY
            JMP BINARY_CONTINUE    
        
                
        ENTER:                  ;ENTER LABEL
                
            CMP FLAG , 49       ;TO DETECT WHICH OUTPUT VALUE IT SHOULD REFER
            JE OUTPUT_HEXA
            
            CMP FLAG , 50
            JE OUTPUT_DEC
            
            CMP FLAG , 51
            JE OUTPUT_DEC           
            
        
        OUTPUT_HEXA:                ;OUTPUT IN HEX LABEL
        
            XOR DX , DX
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
            
            LEA DX , SHOW_HEX       ;PRINT HEX NUMBER MESSAGE
            MOV AH , 9
            INT 21H
            
            MOV CL , 1              ;MOV CL TO 1
            MOV CH , 0              ;MOV CH TO 0
            
            JMP OUTPUT_HEXA2
                   
        
        OUTPUT_HEXA2:           ;OUTPUT_HEXA2 LABEL 
        
            CMP CH , 4          ;COMPARING INPUTS WHETHER INPUTS HAVE BEEN INSERTED FOR 4 TIMES
            JE AGAIN
            INC CH
            
            MOV DL , BH
            SHR DL , 4
            
            CMP DL , 0AH
            JL HEXA_DIGIT
            
            ADD DL,37H     
            MOV AH,2        
            INT 21H          
            ROL BX,4            ;ROTATING 4 BITS TO LEFT   
            
            JMP OUTPUT_HEXA2
                   
        
        HEXA_DIGIT:             ;HEXA_DIGIT LABEL 
        
            ADD DL,30H         
            MOV AH,2       
            INT 21H            
            ROL BX,4
                        
            JMP OUTPUT_HEXA2                    

        
        ERROR_HEX:

            LEA DX,INVALID          ;DISPLAY ERROR MESSAGE
            MOV AH,9                
            INT 21H
                       
        
        HEX_TO_BIN:                 ;HEXA-DECIMAL TO BINARY CONVERSION
                   
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
        
            LEA DX,HEXA_NUMBER
            MOV AH,9                ;DISPLAY MSG_IN
            INT 21H                                 

            JMP START      
                                
    
        START:
            
            XOR BX,BX                   ;CLEAR BX
            MOV COUNT,30H               ;COUNTER=0 
    
    
        INPUT:
    
            MOV AH,1                    ;INPUT
            INT 21H
    
            CMP AL,0DH                  ;COMPARE WITH CR
            JNE SKIP
    
            CMP COUNT,30H               ;COMPARE WITH 0
            JLE ERROR_HEX               ;IF LESS/EQ JUMP TO ERROR
            JMP END                


        SKIP:
    
            CMP AL,"A"      ;COMPARE WITH A
            JL DECIMAL      ;JUMP TO LABEL DECIMAL  IF LESS
    
            CMP AL,"F"      ;COMPARE WITH F
            JG ERROR_HEX    ;JUMP TO LABEL ERROR IF GREATER
    
            ADD AL,09H      ;ADD 9 TO AL
            JMP PROCESS     ;JUMP TO LABEL PROCESS
    

        DECIMAL:
            
            CMP AL,39H      ;COMPARE AL WITH 9
            JG ERROR_HEX    ;IF AL>9 JUMP TO ERROR
                            ;CHECKING IF INVALID
            CMP AL,30H      ;COMPARE WITH 0
            JL ERROR_HEX    ;IF AL<0 JUMP TO ERROR    
    
            JMP PROCESS     ;JUMP TO LABE PROCESS   
    

        PROCESS:
    
            INC COUNT
    
            AND AL,0FH      ;ASCII TO BIN  
            MOV CL,4        ;SET CL=4
            SHL AL,CL       ;SHIFT LEFT SIDE 4 TIMES
            MOV CX,4        ;SET CX=4

    
        LOOP_1:
    
            SHL AL,1        ;SHIFT 1 TIME
            RCL BX,1        ;MOVING THE CARRY TO BX    
    
            LOOP LOOP_1     

            CMP COUNT,34H   ;COMPARE WITH 4
            JE END          ;JUMP TO LABEL END
            JMP INPUT
        
        
        END:
            
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
            
            LEA DX,SHOW_BIN      ;DISPLAY MSG_OUT
            MOV AH,9
            INT 21H

            MOV CX,16
            MOV AH,2
        
        
        LOOP_2:

            SHL BX,1         ;LEFT SHIFT BX 1 TIME
                             ;JUMP IF CARRY=1
            JC ONE
                                              
            MOV DL,30H
            JMP DISPLAY                                          
        
        
        ONE:

            MOV DL,31H
    

        DISPLAY:

            INT 21H  
            LOOP LOOP_2

            JMP AGAIN
                    
        
        BIN_TO_DEC:                     ;BINARY TO DECIMAL CONVERSION LABEL
        
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
            
            
            LEA DX , BINARY_NUMBER      ;BINARY NUMBER INPUT MESSAGE SHOW
            MOV AH , 9
            INT 21H
            
            MOV FLAG , 50
            JMP INPUT_BINARY
                    
        
        OUTPUT_DEC:                 ;OUTPUT DECIMAL NUMBER LABEL
        
            XOR DX , DX
            
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
            
            LEA DX , SHOW_DEC
            MOV AH , 9
            INT 21H
            
            CALL OUT_DECIMALFUN
            JMP MENU_BAR
                     
        
        ERROR_HEX_INPUT:        ;ERROR HEX INPUT LABEL
        
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
            
            LEA DX , INVALID    ;SHOW INVALID NUMBER
            MOV AH , 9
            INT 21H
                        
        
        HEX_TO_DEC:                 ;HEXA-DECIMAL TO DECIMAL CONVERSION LABEL
        
            LEA DX , NEW_LINE
            MOV AH , 9
            INT 21H
            
            LEA DX , HEXA_NUMBER    ;SHOW INPUT HEXA-DECIMAL MESSAGE
            MOV AH , 9
            INT 21H
            
            MOV FLAG , 51
            JMP INPUT_HEX
            
             
        INPUT_HEX:          ;INPUT DECIMAL LABEL
       
            XOR AX , AX     ;CLEARING ALL REGISTERS
            XOR BX , BX
            XOR CX , CX
            XOR DX , DX
            
            MOV COUNT_HEX , 0            
       
       
        INPUT_HEX2:             ;INPUT DECIMAL2 LABEL
        
            CMP COUNT_HEX , 4   ;IF INPUT 4 DIGITS THEN GO ENTER
            JE ENTER
            INC COUNT_HEX
           
            MOV AH , 1          ;INPUT HEXA-DECIMAL NUMBUR
            INT 21H
           
            CMP AL , 0DH
            JE ENTER
           
            CMP AL , 48
            JL ERROR_HEX_INPUT
            
            CMP AL , 58
            JL CONVERT_BIN_SHIFT
            
            CMP AL , 71
            JGE ERROR_HEX_INPUT
            
            SUB AL , 55
            jmp sd                    
        
        
        CONVERT_BIN_SHIFT:      ;CONVERT BINARY SHIFT LABEL
            
            CMP AL , 57
            JG ERROR_HEX_INPUT
            
            AND AL , 0FH        ;CONVERTING TO BINARY AND SHIFT
            
            sd:
            SHL AL , 4
            MOV CX , 4
                    
        
        BIT_SHIFT:              ;BIT SHIFT LABEL
        
            SHL AL , 1
            RCL BX , 1
            LOOP BIT_SHIFT
            JMP INPUT_HEX2
			
        
        EXIT: 
        
            MOV AH , 4CH
            INT 21H  
            
    ;edit
        
    
    Decimal_d:    ; part1
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H        
        LEA DX,NEWL
        INT 21H
        
        LEA DX,Decimal_dINP
        INT 21H
        
        LEA DX,NEWL
        INT 21H
        
        LEA DX,INDecimal_d
        INT 21H
        
        CALL INPUT_Decimal_dFUN         ; CALLING Decimal_d_input FUNCTION
        MOV INP1,BX                     ; INPUT SAVED IS INP1
        
        CMP SELECT,53                   ; FOR BINARY OUTPUT
        JE OUT_BINARY               
                                
        CMP SELECT,54                   ; FOR hexaDecimal_d OUTPUT
        JE OUT_HEXA
        
        
        OUT_BINARY:
            
            MOV AH,9
            LEA DX,NEWL
            INT 21H
            LEA DX,NEWL
            INT 21H
            
            LEA DX,INBINARY
            INT 21H
            
            
            MOV BX,INP1          ; FIX INPUT IN A REGISTER FOR OUTPUT
            CALL OUT_BINARYFUN   ; CALLING binary_output FUNCTION
            
            JMP AGAIN           ; JUMP TO REDO LABEL
            
        
        OUT_HEXA:
            
            MOV AH,9
            LEA DX,NEWL
            INT 21H
            LEA DX,NEWL
            INT 21H
            
            LEA DX,INHEXADecimal_d
            INT 21H
            
            MOV BX,INP1             ; FIX INPUT IN A REGISTER FOR OUTPUT
            CALL OUT_HEXAFUN        ; CALLING hex_output FUNCTION
                
            JMP AGAIN               ; JUMP TO REDO LABEL
        
               
;FUNCTIONS        
        
; input_dec AND CONVERT INTO BINARY(INPUT IN BX)        

        INPUT_Decimal_dFUN PROC
        
                MOV AH,1
                INT 21H
                MOV IND,AL
                
                CMP IND,'-'
                JNE NEXTPOS
                
                JMP BEGIN1
                
                NEXTPOS:
                
                    CMP IND,'+'
                    JNE error_rr
              
                
            BEGIN1:
                 
                XOR BX,BX      
                
                MOV AH,1      
                INT 21H
                
                MOV CX,0
                
                  
        
                REPEAT3:
                    
                    CMP AL,'0'      ;error_rr TEST
                    JL error_rr
                    
                    CMP AL,'9'
                    JG error_rr
                    
                    CMP CX,0
                    JE ADD1
                    
                    CMP CX,1
                    JE ADD2
                    
                    CMP CX,2
                    JE ADD3
                    
                    CMP CX,3
                    JE ADD4 
                    
                    CMP CX,4
                    JE ADD5
                    
                    ADD1:
                    
                        MOV D1,AL
                        JMP WORK 
                        
                    ADD2: 
                    
                        MOV D2,AL
                        JMP WORK
                        
                    ADD3: 
                    
                        MOV D3,AL
                        JMP WORK
                        
                    ADD4:
                    
                        MOV D4,AL
                        JMP WORK 
                        
                    ADD5:
                    
                        MOV D5,AL
                        JMP WORK 
                        
                        
                    
                    WORK: 
                    
                    AND AX,000FH      
                    PUSH AX
                    
                    MOV AX,10     
                    MUL BX        
                    POP BX         
                    ADD BX,AX      
                    
                    INC CX
                    CMP CX,5
                    JE EXIT_X2
                    
                    MOV AH,1    
                    INT 21H
                    
                    CMP AL,0DH   
                    JE EXIT_X1
                            
                    CMP AL,0DH   
                    JNE REPEATING
                    
                        
                    REPEATING:
                        
                        JMP REPEAT3
                    
                    
                    EXIT_X2:
                        
                        MOV AL,D1
                        CMP AL,'6'
                        JG error_rr 
                        CMP AL,'6'
                        JL EXIT_X1
                        CMP AL,'6'
                        JE NEXT2
                        
                            NEXT2:
                            
                                MOV AL,D2
                                CMP AL,'5'
                                JG error_rr
                                CMP AL,'5'
                                JL EXIT_X1 
                                CMP AL,'5'
                                JE NEXT3
                        
                                NEXT3:
                                
                                    MOV AL,D3
                                    CMP AL,'5'
                                    JG error_rr
                                    CMP AL,'5'
                                    JL EXIT_X1 
                                    CMP AL,'5'
                                    JE NEXT4
                        
                                    NEXT4:
                                    
                                        MOV AL,D4
                                        CMP AL,'3'
                                        JG error_rr
                                        CMP AL,'3'
                                        JL EXIT_X1 
                                        CMP AL,'3'
                                        JE NEXT5
                        
                                        NEXT5:
                                        
                                            MOV AL,D5
                                            CMP AL,'5'
                                            JG error_rr                                                                
                                            
                                            
                    EXIT_X1:
                        
                        CMP IND,'-'
                        JE NGD
                        
                        JMP EXIT_XIND
                        NGD:
                        NEG BX
                    
                    EXIT_XIND:       
            
            RET
                            
        INPUT_Decimal_dFUN ENDP    


; output_hex TO BINARY (WORK WITH BX)        
        
        out_hexafun proc
            
            MOV AL , 0
            MOV count_x , AL
            
            XOR DX , DX
            XOR AX , AX
            
            
            MOV CX , 16
            
            while:
            
                SHL DX , 1
                INC count_x
                
                SHL BX , 1
                JC one_x
                
                
                MOV AX , 0
                JMP cont
                
                one_x:
                
                    MOV AX , 1
                
                cont:
                
                    OR DX , AX
                    
                    CMP count_x,4
                    JE pus
                    JMP lp
                    
                    pus:
                    
                        CMP DX , 9
                        JG letter1
                        
                        ADD DX , 30h
                        JMP prnt
                              
                        letter1: 
                        
                        ADD DX , 37h
                        
                        prnt:
                        
                        MOV AH , 2 
                        INT 21h
                        
                        XOR DX , DX
                        MOV count_x,0
                         
                    lp:    
                        LOOP while    
                       
            
            RET
            
         out_hexafun endp   


		; output_decimal from binary

        OUT_DECIMALFUN PROC
        ; output decimal character
        ; from BX register
        
            
            XOR AX , AX
            
            MOV AX , BX
            MOV OUTD , BX
            
           DO:
            
            MOV AX , OUTD
            
            ; compare the register's value
            CMP AX,9999
            JG ATENT
            
            CMP AX,999
            JG AONET
            
            CMP AX,99
            JG AONEH
            
            CMP AX,9
            JG ATEN
            
            CMP AX,0
            JGE AZERO
            
            CMP AX,0
            JL UZERO
            
            
            ATENT:
            ; print a character if register value ( >=10,000 ) 
                
                XOR DX,DX
                
                MOV BX,10000
                DIV BX
                
                MOV REM,DX      ; save remender in REM
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                MOV AX,REM      ; process remender in next step
                
            
            AONET:
            ; print a character if register value ( >=1,000 )
                
                XOR DX,DX
                
                MOV BX,1000
                DIV BX
                
                MOV REM,DX      ; save remender in REM
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                MOV AX,REM      ; process remender in next step
            
            
            AONEH:
            ; print a character if register value ( >=100 )
                
                XOR DX,DX
                
                MOV BX,100
                DIV BX
                
                MOV REM,DX      ; save remender in REM
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                MOV AX,REM      ; process remender in next step
            
            
            ATEN:
            ; print a character if register value ( >=10 )
                
                XOR DX,DX
                
                MOV BX,10
                DIV BX
                
                MOV REM,DX      ; save remender in REM
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                MOV AX,REM      ; process remender in next step
            
            
            AZERO:
            ; print a character if register value ( >=0 )
                
                ADD AL,30H
                
                MOV AH,2
                MOV DL,AL
                INT 21H
                
                JMP BREAK2
            
            
            UZERO:
            ; if register value under '0'
                ; print '-'
                ; -1 * register value
                ; back to the begining process
                
                MOV AH,2
                MOV DL,'-'      ; print '-'
                INT 21H
                
                NEG OUTD        ; -1 * register value
                
                JMP DO          ; back to the begining process
                
            
            BREAK2:
                
            RET
        OUT_DECIMALFUN ENDP


		; output_binary from binary(work with bx)
        
        OUT_BINARYFUN PROC
            
            MOV AH,2
            MOV CX,16      
     
            TOPBIN:
                SHL BX,1       
                JNC ZEROBIN   
                
                MOV DL,49      
                JMP PRINTBIN   
                
                ZEROBIN:          
                    MOV DL,48     
                    
                PRINTBIN:          
                    INT 21H     
                    LOOP TOPBIN            
        
        
            RET
        OUT_BINARYFUN ENDP


	; error_rr message
    
    error_rr:
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        
        LEA DX,error_rrMSG
        INT 21H
        
        JMP AGAIN


	; REPEAT PROGRAMM
    
    again_x:
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H
    

	; end programm
    EXIT_X:
    
        
        MOV AH,9
        LEA DX,NEWL
        INT 21H
        LEA DX,NEWL
        INT 21H 
        LEA DX,NEWL
        INT 21H
        
    
        MOV AH,4CH      ; ignore emulator haulted 
        INT 21H