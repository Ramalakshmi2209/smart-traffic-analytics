
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
org 100h
jmp start1  
arr db 00,00,00,00,00,00,00,00,00,00,00,00,00,00 , 00,00,00,00,00,00,00,00,00,00,00,00,00,00 
count db 0
a db 0
moving db 0
threshold db 5 
msg db "High traffic",0DH,0AH,24H 
msg1 db "INSTRUCTIONS", 0DH,0AH,24H 
msg2 db "1.ENTER 1 IF THE VEHICLE ARRIVES ",0DH,0AH,24H
msg3 db "2.ANY OTHER VALUE IF THE VEHICLE IS NOT PRESENT",0DH,0AH,24H
j db 0
i db 3 
n db 5  
m db 0 
num db 0
square_line db ' ______ ', 0DH, 0AH, '|      |', 0DH, 0AH, '|      |', 0DH, 0AH, '|______|', 0DH, 0AH, '$'
;In this if the cumulative frequency   is greater than threshold it prints that there is a high traffic
start1:
mov ah,9
lea dx,msg1
int 21h
mov ah,9
lea dx,msg2
int 21h 
mov ah,9
lea dx,msg3
int 21h
lea si,arr
start:
inc a 
mov dl,0ah,24h 
mov ah,2
int 21h
mov cl,5
mov ch,0 
mov count,0  
l2:
mov ah,1
int 21h  
cmp al,'1' 
jnz l4
inc count
l4:
loop l2 
mov dl,[si] 
mov dl,count
mov [si],dl
inc j
inc si 
cmp j,5
jnge start
mov moving,0 
mov dl,0 
mov m,0
l9: 
inc m 
dec si
add dl,[si]
cmp m,5
jne l9
mov ah,0
mov al,dl  
mov m,0 
cmp num,0 
jnz l11
l10:
inc si 
inc m
cmp m,5
jne l10
mov ah,0
mov bl,a
div bl
mov moving,al   
jmp l6 
l11:  
inc si 
inc m
cmp m,5
jne l11 
dec a
mov bl,5
div bl
mov moving,al 
inc a  
jmp l6 
l6:  
inc num    
cmp al,threshold   
jle l17
l17:
jne start 
mov dl,0ah  
mov ah,2
int 21h
mov ah,9
lea dx,msg
int 21h

; Check if the user entered '1' and display the square if true
cmp count, '1'
jne end_program

mov ah, 9
lea dx, square_line
int 21h

end_program:
mov dl,7 
mov ah,2 
int 21h 
ret
