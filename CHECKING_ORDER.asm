.model small
.stack 100h
.data
    ; Declare an array of words in the data segment
    arr dw 10, 20, 20, 30, 40, 50, 60, 70, 76, 80, 80, 100, 110, 120, 120, 120, 130
    len dw 17                      ; Length of the array
    msg_asc db 'Ascending$'
    msg_desc db 'Descending$'
    msg_not db 'Not sorted$'

.code
main proc
    mov ax, @data               ; Initialize data segment
    mov ds, ax

    mov cx, len                 ; Load array length into CX
    dec cx                      ; CX = len - 1 for comparisons
    mov si, 0                   ; SI as index for array
    mov bx, 1                   ; Flag for ascending (1 = assume ascending)
    mov dx, 1                   ; Flag for descending (1 = assume descending)

check_loop:
    mov ax, arr[si]             ; Load current element
    cmp ax, arr[si+2]           ; Compare with next element
    jg check_desc               ; If current > next, check descending
    jl check_asc                ; If current < next, check ascending
    ; If equal, continue checking without changing flags
    jmp continue_loop

check_desc:
    ; Current > next, not ascending
    mov bx, 0                   ; Clear ascending flag
    jmp continue_loop

check_asc:
    ; Current < next, not descending
    mov dx, 0                   ; Clear descending flag

continue_loop:
    add si, 2                   ; Move to next element (word = 2 bytes)
    loop check_loop             ; Decrement CX and loop if CX != 0

    ; After loop, check flags to determine order
    cmp bx, 1                   ; Check if ascending flag is still set
    je print_ascending          ; If BX = 1, array is ascending
    cmp dx, 1                   ; Check if descending flag is still set
    je print_descending         ; If DX = 1, array is descending
    jmp print_not_sorted        ; Otherwise, not sorted

print_ascending:
    mov dx, offset msg_asc      ; Load address of ascending message
    jmp print_message

print_descending:
    mov dx, offset msg_desc     ; Load address of descending message
    jmp print_message

print_not_sorted:
    mov dx, offset msg_not      ; Load address of not sorted message

print_message:
    mov ah, 09h                 ; DOS function to print string
    int 21h                     ; Call DOS interrupt

    ; Exit program
    mov ah, 4Ch                 ; DOS function to terminate program
    int 21h

main endp
end main