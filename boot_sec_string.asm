[org 0x7c00] ; tell the compile where BIOS loaded our boot sector to'

mov bx, str ; hold pointer to str
mov ah, 0x0e ; teletype routine

loop:
    cmp byte [bx], 0 ; check if str pointer points to null
    je end ; if it did. jump out of loop

    mov al, [bx] ; set al to deref of str pointer
    int 0x10 ; interrupt cpu to handle bios routine
    inc bx ; increment our pointer.

    jmp loop ; start loop again.

str:
    db "Hello World",0

end:
    jmp $ ; infinite loop

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 
