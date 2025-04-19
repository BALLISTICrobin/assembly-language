.model small
.stack 100h
.data
  a    db '1st number: $'
  b    db '2nd number: $'
  c    db 'summation: $'
  d    db 'difference: $'
.code
main proc
       mov ax, @data
       mov ds, ax

       mov ah,9
       lea dx, a
       int 21h

       mov ah,1
       int 21h
       mov bh, al

       mov ah, 2
       mov dl, 10
       int 21h
       mov dl,13
       int 21h

       mov ah,9
       lea dx, b
       int 21h

       mov ah,1
       int 21h
       mov bl, al

       mov ah, 2
       mov dl, 10
       int 21h
       mov dl,13
       int 21h


       mov ah,9
       lea dx,c
       int 21h

       mov cl, bl
       add bl,bh
       sub cl,bh

       sub bl,48      ;convert ascii to decimal
      

       mov ah,2
       mov dl,bl
       int 21h
  exit:
       mov ah, 4ch
       int 21h
main endp

end main