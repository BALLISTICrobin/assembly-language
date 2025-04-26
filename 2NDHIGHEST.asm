;In this exercise, the user is required to input three lowercase letters. The program
;should then determine and output the second-highest letter based on its ASCII value. The sample
;input and output are illustrated below:


.MODEL SMALL
.STACK 100H
.DATA
    MSG_INPUT  DB 'Enter three lowercase letters: $'
    MSG_OUTPUT DB 13,10,'Second highest: $'
    MSG_EQUAL  DB 13,10,'All letters are equal$'
    CHAR1      DB ?
    CHAR2      DB ?
    CHAR3      DB ?
    NEWLINE    DB 13,10,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

INPUT_LOOP:
    ; Print input prompt
    MOV AH, 09H
    LEA DX, MSG_INPUT
    INT 21H

    ; Read three characters
    MOV AH, 01H
    INT 21H        ; Read first char
    MOV CHAR1, AL
    
    INT 21H        ; Read space
    INT 21H        ; Read second char
    MOV CHAR2, AL
    
    INT 21H        ; Read space
    INT 21H        ; Read third char
    MOV CHAR3, AL

    ; Find second highest
    CALL FIND_SECOND_HIGHEST

    ; Check if user wants to exit (optional)
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H
    JMP INPUT_LOOP

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; ========================================
; Procedure: FIND_SECOND_HIGHEST
; Compares three characters and prints the second highest
; ========================================
FIND_SECOND_HIGHEST PROC
    ; Load characters
    MOV AL, CHAR1
    MOV BL, CHAR2
    MOV CL, CHAR3

    ; Check if all equal
    CMP AL, BL
    JNE NOT_ALL_EQUAL
    CMP AL, CL
    JNE NOT_ALL_EQUAL
    
    ; All letters are equal case
    MOV AH, 09H
    LEA DX, MSG_EQUAL
    INT 21H
    RET

NOT_ALL_EQUAL:
    ; Find second highest using bubble-sort-like comparisons
    ; Compare CHAR1 and CHAR2
    CMP AL, BL
    JAE CHAR1_GREATER_EQUAL_1
    XCHG AL, BL    ; Swap if CHAR1 < CHAR2

CHAR1_GREATER_EQUAL_1:
    ; Now AL >= BL
    ; Compare CHAR1 and CHAR3
    CMP AL, CL
    JAE CHAR1_GREATER_EQUAL_2
    XCHG AL, CL    ; Swap if CHAR1 < CHAR3

CHAR1_GREATER_EQUAL_2:
    ; Now AL contains the highest
    ; Compare CHAR2 and CHAR3 to find second highest
    CMP BL, CL
    JAE SECOND_IS_BL
    ; If we get here, CL is the second highest
    MOV DL, CL
    JMP PRINT_RESULT

SECOND_IS_BL:
    MOV DL, BL

PRINT_RESULT:
    ; Print result
    MOV AH, 09H
    LEA DX, MSG_OUTPUT
    INT 21H
    
    MOV AH, 02H    ; Print character function
    INT 21H
    
    RET
FIND_SECOND_HIGHEST ENDP

END MAIN