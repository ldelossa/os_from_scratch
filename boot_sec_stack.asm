mov ah, 0x0e    ; scrolling teletype ISR

mov bp, 0x8000  ; Set base of the stack above where boot sec is loaded.
mov sp, bp      ; Loads the stack pointer where push/pop will work from.

push 'A'        ; this pushes a byte of data, but each push writes 16bits
push 'B'        ; to ensure stack alignment.
push 'C' 

pop bx          ; we must pop 16 bits so pop into bx and reference lower bits
mov al, bl      
int 0x10        ; interrupt to perform scrolling teletype

pop bx          
mov al, bl      
int 0x10        

pop bx          
mov al, bl      
int 0x10        

jmp $

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 
