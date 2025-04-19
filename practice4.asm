.model small
.stack 100h
.data
msg db 'Loop Concept $'
.code
main proc
  mov ax, @data
  mov ds, ax

  mov ah,9
  lea dx,msg
  int 21h   

  mov ah, 2
  mov dl, 10
  int 21h
  mov dl,13
  int 21h

  mov cx,26
  mov dl,'A'

  level1:
  int 21h  
  inc dl
  loop level1
exit:
mov ah, 4ch
int 21h
main endp

end main

;explain the code
;1. The program starts by defining a small memory model and a stack of 256 bytes.
;2. It declares a data segment with a message "Loop Concept $".
;3. The code segment begins with the main procedure.
;4. It initializes the data segment register DS with the address of the data segment.
;5. It prints the message to the console using interrupt 21h with function 9.
;6. It moves the cursor to the next line by printing a carriage return and line feed using interrupt 21h with function 2.
;7. It initializes the CX register with 26 (the number of letters in the English alphabet) and DL with 'A' (the starting letter).
;8. It enters a loop (level1) that prints the current value of DL (the letter) to the console using interrupt 21h with function 2.
;9. It increments DL to the next letter and decrements CX.
;10. The loop continues until CX reaches 0.
;11. Finally, it exits the program by calling interrupt 21h with function 4Ch.
;12. The program prints the letters A to Z on the console, each on a new line.