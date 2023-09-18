;
; Use BIOS scrolling teletype routine to print Hello.
; 'ah' set to '0x0e' to indicate teletype routine 
; int 0x10 to use interrupt handler routine
; 'al' should hold ASCII character to print
;
; This program is injected directly into the boot sector.
;

mov ah, 0x0e ; value for scrolling teletype BIOS routine
mov al, 'H'  
int 0x10
mov al, 'e'  
int 0x10
mov al, 'l'  
int 0x10
mov al, 'l'  
int 0x10
mov al, 'o'  
int 0x10

jmp $ ; Jump to current address (infinite loop)

times 510-($-$$) db 0 ; Pad until magic

dw 0xaa55 ; Boot sec magic
