[org 0x7c00]

mov bx, HELLO_MSG
call print_string

mov bx, GOODBYE_MSG
call print_string

jmp $

HELLO_MSG:
    db 'Hello, World!',0
GOODBYE_MSG:
    db 'Goodbye (Cruel), World!',0

%include "./lib/print.asm"

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 
