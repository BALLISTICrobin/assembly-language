;compare 3 numbers and print the largest one
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

mov ah,1
int 21h
mov cl,al

cmp bl,bh
jg a

cmp bh,cl
jl b
mov ah,2
mov dl, bh
int 21h
jmp exit

a:
cmp bl,cl
jl c
mov ah,2
mov dl, bl
int 21h
jmp exit

b:
mov ah,2
mov dl, cl
int 21h
jmp exit


c:
mov ah,2
mov dl, cl
int 21h
jmp exit


exit:
mov ah, 4ch
int 21h
main endp

end main