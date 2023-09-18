; dh: number of sectors to read
disk_load:
    push dx         ; dh is number of sectors to read, stash it, can only
                    ; stash full registers so use dx

    mov ah, 0x02    ; BIOS read sector ISR
    mov al, dh      ; read dh sectors
    mov ch, 0x00    ; cylinder 0
    mov dh, 0x00    ; head 0
    mov cl, 0x02    ; sector 2
    int 0x13        ; BIOS disk interrupt

    jc disk_error   ; if carry flag set, error occured

    pop dx          ; restore dx
    cmp dh, al      ; 
    jne disk_error  ;
    ret

; will block system
disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG db "Disk read error!", 0

; ax: blocks to read
; di: start lba
; bx: transfer buffer address
; si: transfer segment to use
; dx: disk number to read from
hdd_load:
    pusha 

    ; reserve DAP on stack
    ; bp          size of packet
    ; bp+1        reserved 0
    ; bp+2        # of blocks to transfer
    ; bp+4        transfer buffer
    ; bp+6        transfer segment
    ; bp+8        start lba
    ; bp+12       start lba
    mov bp, sp
    sub sp, 16

    ; setup DAP
    mov byte [bp],      0x10    ; DAP packet size for internal usage
    mov byte [bp+1],    0       ; reserved
    mov word [bp+2],    ax      ; number of blocks to to read
    mov word [bp+4],    bx      ; transfer buffer address
    mov word [bp+6],    si      ; transfer buffer segment
    mov word [bp+8],    di      ; start lba
    mov word [bp+10],   0       ; pad dword, 16bits is enough for us.
    mov dword [bp+12],  0

    mov si, bp
    mov ah, 0x42
    int 0x13
    jc disk_error

    mov sp, bp
    popa
    ret
