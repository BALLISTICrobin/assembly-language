.model small
.stack 100h
.data
a db 'hello $'
b db 'world $'
c db 'universe $'
.code
main proc
mov ax, @data
mov ds, ax

mov ah,9
lea dx, a
int 21h 

mov ah, 2
mov dl, 10
int 21h
mov dl,13
int 21h
jmp n

mov ah,9
lea dx, b
int 21h 

n:
mov ah,9
lea dx, c
int 21h 

mov ah, 2
mov dl, 10
int 21h
mov dl,13
int 21h


exit:
mov ah, 4ch
int 21h
main endp

end main

;explain the code
;1. The program starts by defining a small memory model and a stack of 256 bytes.
;2. It declares a data segment with three messages: "hello $", "world $", and "universe $".
;3. The code segment begins with the main procedure.
;4. It initializes the data segment register DS with the address of the data segment.
;5. It prints the first message "hello" to the console using interrupt 21h with function 9.
;6. It moves the cursor to the next line by printing a carriage return and line feed using interrupt 21h with function 2.
;7. It jumps to label n, skipping the printing of the second message "world".
;8. It prints the third message "universe" to the console using interrupt 21h with function 9.
;9. It moves the cursor to the next line by printing a carriage return and line feed using interrupt 21h with function 2.
;10. Finally, it exits the program by calling interrupt 21h with function 4Ch.
;11. The program prints "hello" and "universe" on the console, with "world" skipped due to the jump instruction.
;12. The program demonstrates the use of jumps to control the flow of execution in assembly language.