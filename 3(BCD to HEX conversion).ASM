input macro
mov ah,01h
int 21h
endm

output macro
mov ah,02h
int 21h
endm

display1 macro var
lea dx,var;mov dx, offset var
mov ah,09h
int 21h
endm

.model small
.stack 100h

.data
m1 db 10,13,09,"Enter 5 digit BCD No :$"
m2 db 10,13,09,"Equivalent Hexadecimal No :$"
m3 db 10,13,09,"Invalid Entery$"

arr dw 2710h,03e8h, 0064h, 000ah, 0001h

cnt db 05h

res dw 0000h

.code

mov ax,@data
mov ds,ax

display1 m1

lea si,arr

back:input
     cmp al,30h
     jb inv
     cmp al,39h
     jg inv
     cmp al,39h
     jbe next
     sub al,07h

next:sub al,30h
     mov ah,00h
     mov cx,[si]
     mul cx
     add res,ax
     inc si
     inc si
     dec cnt
     jnz back
     display1 m2

     mov ch,04
     mov cl,04
     mov bx,res

k1:rol bx,cl
   mov dl,bl
   and dl,0fh
   cmp dl,09h
   jbe k2
   add dl,07h

k2:add dl,30h
   output
   dec ch
   jnz k1
   jmp exit

inv: display1 m3

exit :
mov ah,4ch
int 21h
end         ;EXAMPLE-BCD(65530) == HEX(FFFA)
