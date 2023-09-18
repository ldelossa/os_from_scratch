[org 0x7c00] ; tell the compile where BIOS loaded our boot sector to

mov dx, 0x1ab6
call print_hex

jmp $

%include "./lib/print.asm"

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 
