;upper to lower
.model small
.stack 100h
.data

char db ?

.code
main proc
mov ah, 1
int 21h
mov bl, al

mov char ,bl
add char,32

mov ah,2
mov dl, char
int 21h

exit:
mov ah, 4ch
int 21h
main endp

end main