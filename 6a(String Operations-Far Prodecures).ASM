input macro
mov ah,01h
int 21h
endm

display1 macro var
lea dx, var
mov ah,09h
int 21h
endm

public inputstring1, inputstring2
extrn concatenate:far, compare:far

.model small
.stack 100h

.data
m1 db 10,13,09,"Enter String1 : $"
m2 db 10,13,09,"Enter String2 : $"
m3 db 10,13,09,"Menu : ", 10,13,09,"1.Concatenate ",10,13,09,"2.Compare ", 10,13,09,"3.Exit $"
m4 db 10,13,09,"$"

inputstring1 db 25 dup('$')
inputstring2 db 25 dup('$')

.code

mov ax,@data
mov ds,ax
mov es,ax

display1 m1
lea dx, inputstring1
mov ah, 0ah
int 21h 

display1 m4

display1 m2
lea dx, inputstring2
mov ah, 0ah
int 21h 

display1 m4

menu:display1 m3

display1 m4

input

cmp al,31h
je con

cmp al,32h
je com

cmp al,33h
je exit

con:call concatenate
    jmp menu

com:call compare
    jmp menu

exit:mov ah,4ch
     int 21h
     end



