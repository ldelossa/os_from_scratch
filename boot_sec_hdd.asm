; Read some sectors from the boot disk using disk.asm lib
[org 0x7c00]
    
    mov bp, 0x8000          ; Set stack out of way of boot sector
    mov sp, bp              

    mov ax, 2       ; blocks to read
    mov di, 1       ; starting LBA (zero based, so sector after boot_sec)
    mov bx, 0x9000  ; transfer to memory at 0x9000
    mov si, 0x0     ; don't use a segment 
    
    call hdd_load

    mov dx, [0x9000]        ; print out first loaded word, expect 0xdada
    call print_hex

    mov dx, [0x9000+512]        ; print out first loaded word, expect 0xdada
    call print_hex

    jmp $

%include "./lib/print.asm"
%include "./lib/disk.asm"

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 

; add more sectors to our boot image for testing.
times 256 dw 0xdada
times 256 dw 0xface
