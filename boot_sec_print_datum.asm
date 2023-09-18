[org 0x7c00] ; tell the compile where BIOS loaded our boot sector to

mov ah, 0x0e ; teletype routine selector
mov al, [datum] ; will derefence (org + offset_to_datum)
int 0x10 ;

datum:
    db "X" ; store a byte of data 

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 
