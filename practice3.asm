.model small
.stack 100h
.data
  val  db 'My name is Robin $'

.code
main proc
       mov ax,@data
       mov ds, ax

       mov ah,9
       lea dx, val; lea means load effective address
       int 21h

  exit:
       mov ah, 4ch
       int 21h
main endp

end main 

;explain the code
;1. The program starts by defining a small memory model and allocating a stack of 256 bytes.
;2. It declares a data segment with a string variable 'val' initialized to "
;My name is Robin $". The '$' character is used as a string terminator for DOS functions.
;3. The code segment begins with the 'main' procedure.
;4. It initializes the data segment register (DS) with the address of the data segment.
;5. The program uses DOS interrupt 21h with function 9 to print the string stored in 'val'.
;6. The string is printed to the console until the '$' character is encountered, which indicates the end of the string.
;7. Finally, the program exits by calling DOS interrupt 21h with function 4Ch, which terminates the program and returns control to the operating system.