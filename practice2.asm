.model small
.stack 100h
.data
  val        db 3
  UnknownVal db ?

.code
main proc
       mov ax,@data
       mov ds, ax

       add val,48
       mov ah, 2
       mov dl, val
       int 21h

       mov ah, 2
       mov dl, 10
       int 21h
       mov dl,13
       int 21h

       mov ah,1
       int 21h
       mov bl, al

       mov ah, 2
       mov dl, 10
       int 21h
       mov dl,13
       int 21h

       mov ah,2
       mov dl,bl
       int 21h

  exit:
       mov ah, 4ch
       int 21h
main endp
end main


;explain the code
;1. The program starts by defining a small memory model and allocating a stack of 256 bytes.
;2. It declares a data segment with a byte variable 'val' initialized to 3 and an uninitialized byte variable 'UnknownVal'.
;3. The code segment begins with the 'main' procedure.
;4. It initializes the data segment register (DS) with the address of the data segment.
;5. The value of 'val' is converted to its ASCII representation by adding 48 (the ASCII value of '0') to it.
;6. The program then prints the ASCII character corresponding to the value of 'val' using DOS interrupt 21h with function 2.
;7. It prints a newline by sending ASCII values for line feed (10) and carriage return (13) to the output.
;8. The program waits for a single character input using DOS interrupt 21h with function 1 and stores it in the BL register.
;9. It prints another newline using the same method as before.  
