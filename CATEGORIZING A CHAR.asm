;Prompt the user to input a single printable ASCII character. Categorize the input
;character into the following classifications:

.model small
.stack 100h
.data
char db ?
MSG1 DB 'Others $'
MSG2 DB 'Number $'
MSG3 DB 'Upper Case $'
MSG4 DB 'Lower Case $'
.code

main proc
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,1
    INT 21H
    MOV BL,AL
    
    MOV AH, 9
    
    CMP BL, 48
    JL OTHER
    CMP BL, 57
    JLE NUMBER
    
    CMP BL,65
    JL OTHER
    CMP BL, 90
    JLE UPPERCASE
    
    
    CMP BL,97
    JL OTHER
    CMP BL, 122
    JLE LOWERCASE
    
    JMP OTHER 
    
    
    
    
    
    
    
    OTHER:
    LEA DX, MSG1
    
    
    JMP EXIT
    
    NUMBER:
    LEA DX, MSG2
    
    
    JMP EXIT
    
    UPPERCASE:
    LEA DX, MSG3
    
    
    JMP EXIT
    
    
    LOWERCASE:
    LEA DX, MSG3
    
    
    JMP EXIT
    
    EXIT:
    INT 21H
    MOV AH, 4CH
    INT 21H
    
MAIN ENDP

END MAIN

    