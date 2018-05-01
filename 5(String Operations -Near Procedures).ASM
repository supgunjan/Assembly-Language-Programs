input macro 
mov ah,01h
int 21h
endm

output macro 
mov ah,02h
int 21h
endm

display1 macro var
lea dx,var
mov ah,09h
int 21h
endm

.model small
.stack 100h

.data
m1 db 10,13,09,"Enter String : $"
m2 db 10,13,09,"Menu : ", 10,13,09,"1.Length", 10,13,09,"2.Reverse", 10,13,09,"3.Palindrome", 10,13,09,"4.Exit$"
m3 db 10,13,09,"Length : $"
m4 db 10,13,09,"Reverse : $"
m5 db 10,13,09,"Not a Palindrome$"
m6 db 10,13,09,"Palindrome$"
m7 db 10,13,09,"$"

str1 db 20,?,20 dup(0)

.code
mov ax,@data
mov ds,ax

display1 m1
lea dx,str1
mov ah, 0ah
int 21h

menu: display1 m2
      display1 m7
      input
      display1 m7


cmp al,31h
je len

cmp al,32h
je rev

cmp al,33h
je pal

jmp exit

len: call length1
jmp menu

rev: call reverse1
jmp menu

pal: call palindrome1
jmp menu

proc length1 near

display1 m3
lea si,str1[1]
mov bl,[si]

mov ch,02h
mov cl,04h

k1:rol bl,cl
   mov dl,bl
   and dl,0fh
   cmp dl,09
   jbe k2
   add dl,07h

k2:add dl,30h
output
dec ch
jnz k1

ret
endp

proc reverse1 near

display1 m4

xor cx,cx

lea si,str1[1]
mov cl,[si]

add si,cx

k3:mov ah,02h
   mov dl,[si]
   int 21h

   dec si
   dec cx
   jnz k3

ret
endp

proc palindrome1 near

and cx,00h
lea si,str1[1]
mov cl,[si]

add si,cx
inc si

lea di,str1[1]

k4:inc di
   dec si
   mov al,[di]
   cmp al,[si]
   jne done
   dec cx
   jnz k4

   display1 m6
   ret

done: display1 m5
      
ret
endp

exit: mov ah,4ch
      int 21h
      end
 













