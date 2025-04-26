.model small
.stack 100h
.data
    ; Declare the string in the data segment
    str1 db 'uyhitnaeF', '$'        ; Test case 1 (can be changed to others)
    ; str1 db 'qwertykeyboards', '$' ; Test case 2
    ; str1 db 'erulaaagerulaaag', '$' ; Test case 3
    vowel_count dw 0                ; Store vowel count
    consonant_count dw 0            ; Store consonant count
    msg_vowel db 'Vowel Count: $'
    msg_consonant db 13, 10, 'Consonant Count: $' ; Include CR+LF for new line
    num_buffer db 6 dup('$')        ; Buffer for printing numbers

.code
main proc
    mov ax, @data               ; Initialize data segment
    mov ds, ax

    mov si, offset str1         ; Point SI to start of string
    xor bx, bx                  ; Clear BX (vowel count)
    xor dx, dx                  ; Clear DX (consonant count)

check_loop:
    mov al, [si]                ; Load current character
    cmp al, '$'                 ; Check for string terminator
    je done                     ; If '$', exit loop

    ; Check if character is a vowel
    cmp al, 'a'
    je is_vowel
    cmp al, 'e'
    je is_vowel
    cmp al, 'i'
    je is_vowel
    cmp al, 'o'
    je is_vowel
    cmp al, 'u'
    je is_vowel
    jmp is_consonant            ; If not a vowel, it's a consonant

is_vowel:
    inc bx                      ; Increment vowel count
    jmp next_char

is_consonant:
    inc dx                      ; Increment consonant count

next_char:
    inc si                      ; Move to next character
    jmp check_loop              ; Continue loop

done:
    mov vowel_count, bx         ; Store vowel count in memory
    mov consonant_count, dx     ; Store consonant count in memory

    ; Print "Vowel Count: "
    mov ah, 09h
    mov dx, offset msg_vowel
    int 21h

    ; Print vowel count
    mov ax, vowel_count
    call print_number

    ; Print "Consonant Count: " (with newline)
    mov ah, 09h
    mov dx, offset msg_consonant
    int 21h

    ; Print consonant count
    mov ax, consonant_count
    call print_number

    ; Exit program
    mov ah, 4Ch
    int 21h

main endp

; Procedure to print a number
print_number proc
    push ax
    push bx
    push cx
    push dx
    mov bx, 10              ; Base 10
    xor cx, cx              ; Digit count
convert_loop:
    xor dx, dx
    div bx                  ; AX = quotient, DX = remainder
    add dl, '0'             ; Convert remainder to ASCII
    push dx                 ; Save digit
    inc cx                  ; Increment digit count
    cmp ax, 0               ; Check if quotient is 0
    jne convert_loop
print_loop:
    pop dx                  ; Get digit
    mov ah, 02h             ; Print character
    int 21h
    loop print_loop
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

end main