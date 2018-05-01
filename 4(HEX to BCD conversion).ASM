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
m1 db 10,13,09,"Enter 4 digit Hex No :$"
m2 db 10,13,09,"Equivalent BCD No :$"
m3 db 10,13,09,"Invalid Entery$"

op1 dw ?

count db 00h

.code

mov ax,@data
mov ds,ax

display1 m1

mov cx,0404h
mov dx,0000h

back:input

cmp al,30h
jb inv
cmp al,39h
jg next1
sub al,30h
jmp below

next1:cmp al,41h	;a to f
      jb inv
      cmp al,46h
      jg next2
      sub al,37h
      jmp below

next2:cmp al,61h	;A to F
      jb inv
      cmp al,66h
      jg inv
      sub al,57h

below:rol dx,cl
      mov ah, 00h
      add dx,ax
      dec ch
      jnz back

       mov op1,dx

       display1 m2

       mov ax,op1

up:mov dx,0000h
   mov bx,000ah
   div bx
   push dx
   inc count
   cmp ax, 0000h
   jnz up

above:
   pop dx
   add dl,30h
   output
   dec count
   jnz above
   jmp exit

inv:  display1 m3
      jmp exit

exit:mov ah,4ch
     int 21h
     end	;EXAMPLE-HEX(1234) == BCD(4660) 
