;find largest number
.model small
.stack 100h
.data

.code
main proc
mov ah,1
int 21h
mov bl,al

mov ah,1
int 21h
mov bh,al

cmp bl,bh
jg bl_is_largest
jmp bh_is_largest

bl_is_largest:
mov ah, 2
mov dl,bl
int 21h

bh_is_largest:
mov ah, 2
mov dl,bh
int 21h

exit:
mov ah, 4ch
int 21h
main endp

end main