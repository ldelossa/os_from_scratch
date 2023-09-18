; Read some sectors from the boot disk using disk.asm lib
[org 0x7c00]

    mov [BOOT_DRIVE], dl    ; BIOS stores boot drive in dl, stash it.
    call print_hex

    mov bp, 0x8000          ; Set stack out of way of boot sector
    mov sp, bp              

    mov bx, 0x9000          ; read 5 sectors to es:bx (es=0)
    mov dh, 5
    mov dl, [BOOT_DRIVE]
    call disk_load

    mov dx, [0x9000]        ; print out first loaded word, expect 0xdada
    call print_hex

    mov dx, [0x9000 + 512]  ; also print first word from 2nd loaded sector,
                            ; expect 0xface

    jmp $

%include "./lib/print.asm"
%include "./lib/disk.asm"

BOOT_DRIVE: db 0

; Fill with 510 zeros minus the size of the previous code
times 510-($-$$) db 0
; Magic number
dw 0xaa55 

; add more sectors to our boot image for testing.
times 256 dw 0xdada
times 256 dw 0xface
