input macro
mov ah, 01h
int 21h
endm

output macro
mov ah, 02h
int 21h
endm

display1 macro var
lea dx, var
mov ah, 09h
int 21h
endm

.model small
.stack 100h

.data
m1 db 10,13,09,"How many numbers to want to enter : $"
m2 db 10,13,09,"Enter No : $"
m3 db 10,13,09,"Addition : $"
m4 db 10,13,"$"

arr db 10 dup(0)
count db 0

.code 
mov ax,@data
mov ds,ax

display1 m1
input
sub al,30h

mov count,al
mov cl,count

lea si,arr

k1 : display1 m2
     input
     mov [si],al
     inc si
     loop k1

display1 m4
display1 m3

xor ax,ax
mov cl,count

lea si,arr

k2:add al,[si]
   sub al,30h
   inc si
   loop k2

mov bl,al
mov ch, 02h
mov cl, 04h

k3:rol bl,cl
   mov dl,bl
   and dl,0fh
   cmp dl,09
   jbe k4
   add dl,07h

k4:add dl,30h
   
output
dec ch
jnz k3

mov ah,4ch
int 21h
end



  

