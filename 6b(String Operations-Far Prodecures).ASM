display1 macro var
lea dx, var
mov ah,09h
int 21h
endm

public concatenate, compare
extrn inputstring1:byte, inputstring2:byte

.model small
.stack 100h

.data
m1 db 10,13,09,"Concatenated String : $"
m2 db 10,13,09,"Equal$"
m3 db 10,13,09,"Not Equal$"
m4 db 10,13,09,"$"

inputstring3 db 50 dup('$')

.code

mov ax,@data
mov ds,ax
mov es,ax

proc concatenate far

mov ch,00h

lea si,inputstring1[1]
mov cl,[si]

lea si,inputstring1[2]
lea di,inputstring3[2]

repz movsb

mov ch,00h

lea si,inputstring2[1]
mov cl,[si]

lea si,inputstring2[2]

repz movsb

display1 m4

lea si,inputstring3
lea dx,inputstring3+2
mov ah,09h
int 21h

display1 m4

ret
endp

proc compare far

xor cx,cx
xor ax,ax

lea si,inputstring1[1]
lea di,inputstring2[1]

mov cl,[si] 
cmp cl,[di]

jne k3

repe cmpsb
jne k3

display1 m2
display1 m4
ret

k3: display1 m3
    display1 m4
    ret

endp

mov ah,4ch
int 21h
end