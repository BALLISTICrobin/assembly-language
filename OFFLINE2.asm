.model small
.stack 100h
.data
    n dw ?                      ; Initial number of chocolates
    k dw ?                      ; Wrappers needed for one chocolate
    total dw ?                  ; Total chocolates eaten
    wrappers dw ?               ; Current number of wrappers
    num_buffer db 6 dup('$')    ; Buffer for input/output numbers
    space db ' $'               ; Space separator for input

.code
main proc
    mov ax, @data           ; Initialize data segment
    mov ds, ax

    ; Read input: n and k
    call read_number        ; Read n
    mov n, ax
    call read_space         ; Skip space
    call read_number        ; Read k
    mov k, ax

    ; Initialize variables
    mov ax, n               ; Total chocolates = n
    mov total, ax
    mov wrappers, ax        ; Wrappers = n

exchange_loop:
    mov ax, wrappers        ; Check if wrappers >= k
    cmp ax, k
    jl done                 ; If wrappers < k, exit loop

    ; Exchange k wrappers for 1 chocolate
    mov ax, wrappers
    xor dx, dx
    div k                   ; AX = wrappers / k (new chocolates)
    add total, ax           ; Add new chocolates to total
    mov bx, ax              ; Save new chocolates
    mul k                   ; AX = new chocolates * k (wrappers used)
    sub wrappers, ax        ; Subtract used wrappers
    add wrappers, bx        ; Add new wrappers from new chocolates
    jmp exchange_loop       ; Repeat

done:
    ; Output total chocolates
    mov ax, total
    call print_number

    ; Exit program
    mov ah, 4Ch
    int 21h

main endp

; Procedure to read a number from input
read_number proc
    push bx
    push cx
    xor bx, bx              ; Clear BX (result)
    mov cx, 10              ; Base 10 for digit conversion
read_loop:
    mov ah, 01h             ; Read character
    int 21h
    cmp al, 13              ; Check for Enter (carriage return)
    je read_done
    sub al, '0'             ; Convert ASCII to digit
    mov ah, 0
    push ax                 ; Save digit
    mov ax, bx
    mul cx                  ; BX = BX * 10
    mov bx, ax
    pop ax                  ; Restore digit
    add bx, ax              ; BX = BX + digit
    jmp read_loop
read_done:
    mov ax, bx              ; Return result in AX
    pop cx
    pop bx
    ret
read_number endp

; Procedure to read space
read_space proc
    mov ah, 01h             ; Read character
    int 21h
    ret
read_space endp

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