output macro 
mov ah,02h
int 21h
endm

display1 macro var
lea dx,var        ;mov dx, offset var
mov ah,09h
int 21h
endm

.model small
.stack 100h

.data

arr db 01h, 02h, 03h, 04h, 05h

cnt db 05h

m1 db 10,13,09, "Addition : $"

.code

mov ax,@data
mov ds,ax

display1 m1

lea si, arr
xor ax,ax
xor cx,cx

k1:
add al,[si]
inc si
dec cnt
jnz k1

mov ch, 02h
mov cl, 04h

mov bl,al

k2:rol bl,cl
   mov dl,bl
   and dl,0fh
   cmp dl,09h
   jbe k3
   add dl,07h

k3:add dl,30h
   output
   dec ch
   jnz k2
   jmp exit

exit:
mov ah,4ch
int 21h
end