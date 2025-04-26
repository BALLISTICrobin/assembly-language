;Print all elements of an array
.MODEL SMALL
.STACK 100H
.DATA
    ARR DB 10, 20, 30, 40, 50   ; Array of 5 numbers
    N   DB 5                    ; Number of elements
    NEWLINE DB 13,10,'$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX                                                 
    

    MOV CL, N       ; Counter = number of elements
    XOR CH, CH      ; Clear upper bits
    LEA SI, ARR     ; SI points to start of array

PRINT_LOOP:
    MOV AL, [SI]    ; Load current array element into AL
    MOV AH, 0
    MOV BL, 10
    DIV BL          ; AL = AL/10, AH = AL%10

    ; Now AL = tens digit, AH = units digit

    MOV BH, AH      ; ?? Save remainder (units) into BH

    ; Print tens digit
    ADD AL, '0'     ; Convert tens to ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H

    ; Print units digit
    MOV DL, BH      ; Get saved remainder
    ADD DL, '0'     ; Convert units to ASCII
    MOV AH, 02H
    INT 21H

    ; Print newline
    MOV AH, 09H
    LEA DX, NEWLINE
    INT 21H

    INC SI          ; Move to next array element
    LOOP PRINT_LOOP

    ; Exit program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
