; GDT
gdt_start:

gdt_null: 	; mandatory null descriptor
	dd 0x0	; 'dd' means define double word (4 bytes)
	dd 0x0

gdt_code:			; code segment descriptor
	dw 0xffff		; Limit (bits 0-15)
	dw 0x0			; Base (bits 0-15)
	dw 0x0			; Base (bits 16-23)
	db 10011010b	; 1st flags, type flags
	db 11001111b	; 2nd flags, Limit (bits 16-19)
	db 0x0			; Base (Bits 24-31)

gdt_data:			; data segment descriptor
	dw 0xffff		; Limit (bits 0-15)
	dw 0x0			; Base (bits 0-15)
	dw 0x0			; Base (bits 16-23)
	db 10010010b	; 1st flags, type flags
	db 11001111b	; 2nd flags, Limit (bits 16-19)
	db 0x0			; Base (Bits 24-31)

gdt_end:			; used to calculate size of GDT

gdt_descriptor:
	dw gdt_end - gdt_start - 1 
	dd gdt_start

CODE_SEG eq gpt_code - gdt_start
DATA_SEG eq gdt_data - gdt_start
