hex_chars:
    db '0123456789ABCDEF'
;
; bx is pointer to null terminated string
;
print_string:
    pusha               ; pushes all registers to stack, str pointer is top of stack (di)
    mov ah, 0x0e        ; set teletype ISR 
loop:
    cmp byte [bx], 0    
    je print_str_end    
    mov al, [bx]        
    int 0x10
    inc bx
    jmp loop   
print_str_end:
    popa
    ret

;
; print a 16 bit integer as hex
; dx register holds integer
;
print_hex:
    pusha

    mov bp, sp 
    ; stack vars
    ; bp            str pointer (8 bytes)
    sub sp, 8;

    ; ax: input integer shift op / ascii hex char
    ; bx: hex_chars[0] pointer
    ; cl: left shift amount
    ; si: char pointer offset from bp
    ; dx: 16bit integer to print
    mov cl, 12;
    mov si, 0;

print_hex_loop:
    cmp cl, byte 0
    jl print_hex_end

    mov bx, hex_chars   ; set bx to hex_chars[0]
    
    ; shift input integer and extract hex ascii into bx
    mov ax, dx          ; set ax to our input integer
    shr ax, cl          ; shift by al to get target nibble
    and ax, 0x000F      ; mask out nibble
    add bx, ax          ; index into hex_chars, can reuse ax now...

    mov al, [bx]        ; al now contains ascii char for nibble

    mov [bp+si], al     ; write ascii char in al to char pointer

    sub cl, 4           ; subtract shift operand to get following nibble
    add si, 1           ; increment stack char pointer by a byte
    jmp print_hex_loop  ; loop it baby!

print_hex_end:
    mov [bp+si], byte 0      ; add null byte to terminate string
    mov bx, bp               ; bp points to top of string, print_str arg in bx
    call print_string

    mov sp, bp          ; cleanup stack and return
    popa                ;
    ret                 ;
