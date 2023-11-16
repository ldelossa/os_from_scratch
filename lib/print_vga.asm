[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; prints a string pointer in EBX to video memory
print_string_pm:
	pusha 
	mov edx, VIDEO_MEMORY ; set edx to start of video memory

print_string_pm_loop:
	mov al, [ebx]		  	; set low bit of a to current char value
	mov ah, WHITE_ON_BLACK	; set high bit of a to colors

	cmp al, 0			
	je print_string_pm_done

	mov [edx], ax			; store current char and attributes at memory pointer

	add ebx, 1				; Increment EBX to the next char
	add edx, 2				; Move to next video 

	jmp print_string_pm_loop 

print_string_pm_done:
	popa 
	ret
